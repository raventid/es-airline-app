require_relative 'gems/bundler/setup'

require 'eventide/postgres'
require 'consumer/postgres'
require 'component_host'

class CalculateOptimal
  include Messaging::Message

  attribute :fare_id, String
  attribute :amount, Numeric
  attribute :time, String
end

class CalculatedOptimal
  include Messaging::Message

  attribute :fare_id, String
  attribute :amount, Numeric
  attribute :time, String
  attribute :processed_time, String
end

class CalculationOfOptimalHasFailed
  include Messaging::Message

  attribute :fare_id, String
  attribute :amount, Numeric
  attribute :time, String
end

# Pure logic, no knoledge about commands or events
class AdditionalFare
  include Schema::DataStructure

  attribute :id, String
  attribute :fare, Numeric, default: 0
  attribute :price, Numeric

  def apply(fare)
    self.fare = fare if better?(fare)
  end

  def better?(fare)
    self.price > fare.price
  end
end

# Account transformation to and from JSON for entity snapshotting
class Account
  module Transform
    # When reading: Convert hash to Account
    def self.instance(raw_data)
      Account.build(raw_data)
    end

    # When writing: Convert Account to hash
    def self.raw_data(instance)
      instance.to_h
    end
  end
end

# Account entity projection
# Applies account events to an account entity
class Projection
  include EntityProjection

  entity_name :additional_fare

  apply CalculatedOptimal do |calculated|
    amount = calculated.price
    additional_fare.apply(amount)

    # It's impossible to know which even will be received first
    # so assign the fare ID in every event's projection
    additional_fare.id = calculated.fare_id
  end
end

class Store
  include EntityStore

  category :additional_fare
  entity AdditionalFare
  projection Projection
  reader MessageStore::Postgres::Read
  snapshot EntitySnapshot::Postgres, interval: 5
end

# Account command handler with withdrawal implementation
# Business logic for processing a withdrawal
class Handler
  include Messaging::Handle
  include Messaging::StreamName

  dependency :write, Messaging::Postgres::Write
  dependency :clock, Clock::UTC
  dependency :store, Store

  def configure
    Messaging::Postgres::Write.configure(self)
    Clock::UTC.configure(self)
    Store.configure(self)
  end

  category :additional_fare

  handle CalculateOptimal do |calculate|
    fare_id = calculate.account_id

    time = clock.iso8601

    calculated = CalculatedOptimal.follow(calculate)
    calculated.processed_time = time

    stream_name = stream_name(fare_id)

    write.(deposited, stream_name)
  end
end

# The consumer dispatches in-bound messages to handlers
# Consumers have an internal reader that reads messages from a single stream
# Consumers can have many handlers
class AdditionalFareConsumer
  include Consumer::Postgres

  handler Handler
end

# The "Component" module maps consumers to their streams
# Until this point, handlers have no knowledge of which streams they process
# Starting the consumers starts the stream readers and gets messages
# flowing into the consumer's handlers
module Component
  def self.call
    additional_fare_command_stream_name = 'additional_fare:command'
    AdditionalFareConsumer.start(additional_fare_command_stream_name)
  end
end

# ComponentHost is the runnable part of the service
# Register the Start module with the component host, then start the
# component and messages sent to its streams are dispatched to the handlers
component_name = 'additional-fare-service'
ComponentHost.start(component_name) do |host|
  host.register(Component)
end
