# Define a handler for the stream you wish to update your view data.

# TODO: NOOOOOOOOO, MONOREPO MAKES ME PRODUCE BAD CODE.
# Yeah, it's not my fault, it's MONOREPO!

# TODO: Maybe build a separate library to update Mongodb from events?

require 'mongoid'

require 'component_host'

require 'active_support/all'

require_relative '../search-fare-component/init.rb'

# FareFound event from search_fare (will use only one to build a mat.view)
require_relative '../search-fare-component/lib/search_fare_component/messages/events/fare_found.rb'

require_relative '../search-fare-component/lib/search_fare_component/messages/events/found_one_of_the_fares.rb'

# SearchFare view-model which maps to mongodb collection for this response.
require_relative '../web/view_models/search_fare.rb'

Mongoid.load!("./settings/mongoid.yml", :development)

module SearchFareViewComponent
  module Handlers
    class Events
      include Messaging::Handle
      include Messaging::StreamName
      include Log::Dependency

      dependency :clock, Clock::UTC
      dependency :write, Messaging::Postgres::Write

      def configure
        Clock::UTC.configure(self)
        Messaging::Postgres::Write.configure(self)
      end

      # Collecting data about fares
      handle SearchFareComponent::Messages::Events::FoundOneOfTheFares do |fare_found|
          id = fare_found.search_fare_id

          view = ViewModels::SearchFare.where(key: id.to_s).first

          if !view
            view = ViewModels::SearchFare.new(
              key: id,
              status: "in_progress",
            )
          end

          view.fares << ViewModels::Fare.new(
            fare_rules: fare_found.data[:rules][:text],
            fare_price: fare_found.data[:prices][:fare],
            taxe_price: fare_found.data[:prices][:taxes],
            total_price: fare_found.data[:prices][:total],
          )

          view.save!
      end

      # Fare completely found. Finishing rendering view.
      handle SearchFareComponent::Messages::Events::FareFound do |fare_found|
        id = fare_found.search_fare_id

        view = ViewModels::SearchFare.where(key: id.to_s).first

        view.status = "completed"

        view.save!
      end
    end
  end
end

# Add a consumer
module SearchFareViewComponent
  module Consumers
    class Events
      include Consumer::Postgres
      handler Handlers::Events

      identifier :search_fare_view
    end
  end
end

# Start both consumers
module SearchFareViewComponent
  module Start
    def self.call
      Consumers::Events.start('searchFare')
    end
  end
end

# ComponentHost is the runnable part of the service
# Register the component module with the component host, then start the
# component and messages sent to its streams are dispatched to the handlers
component_name = 'search-fare-service'
ComponentHost.start(component_name) do |host|
  host.register(SearchFareViewComponent::Start)
end
