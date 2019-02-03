# Handler user guide: http://docs.eventide-project.org/user-guide/handlers.html
# Message user guide: http://docs.eventide-project.org/user-guide/messages-and-message-data/

module SearchFareComponent
  module Handlers
    class Events
      include Messaging::Handle
      include Messaging::StreamName
      include Log::Dependency
      include Messages::Events

      dependency :write, Messaging::Postgres::Write
      dependency :clock, Clock::UTC
      dependency :store, Store

      def configure
        Messaging::Postgres::Write.configure(self)
        Clock::UTC.configure(self)
        Store.configure(self)
      end

      category :search_fare
      # Note: Delete this file if not handling events

      # TODO Implement event handler blocks
      # eg:
      # handle SomethingHappened do |something_happened|
      # end
      handle InitiatedFindFare do |initiated|
        # We initiated the search
        #
        # 1. register_flight_parts in entity
        search_fare_id = initiated.search_fare_id
        search_fare, version = store.fetch(search_fare_id, include: :version)

        # 2. Iterate over request and get flight parts
        commands = initiated.request.map do |key, value|
          # 3. Get gds name
          gds_name = value[:gds]

          # 4. Issue command for every GDS gateway.
          id = Identifier::UUID::Random.get # Here should be `gds`-generator
          find_fare = ::Wolfgang::Client::Messages::Commands::FindFare.new
          find_fare.part = key.to_s # part is a key
          # TODO: how to copy meta?
          find_fare.metadata.follow(initiated.metadata)
          find_fare.wolfgang_id = id # Here should be `gds_name`_id
          find_fare.time = '2000-01-01T11:11:11.000Z' # better way?

          command_stream_name = "#{gds_name}:command-#{id}" # how to incapsulate?

          # 5. wrap every part with command
          # TODO: There's no possibility to stub this message right now
          # we should made an object command in Wolfgang and import it here.
          # So we can register it as dependency and run isolated tests.

          write.(find_fare, command_stream_name)
        end
      end

      handle FoundOneOfTheFares do |found_one_of_the_fares|
        search_fare_id = found_one_of_the_fares.search_fare_id
        search_fare, version = store.fetch(search_fare_id, include: :version)

        logger.info("Finalizing found_one_of_the_fares handler search_fare: #{search_fare_id}")

        stream_name = stream_name(search_fare_id)

        # Catch every FoundOneOfTheFares event.
        # If we already found all of the fares for current search_fare, then
        # we can issue our terminating event - FareFound.
        return unless search_fare.fare_found?

        logger.info("Every fare found. Event processed (Command: #{found_one_of_the_fares.message_type}, SearchFare ID: #{search_fare_id})")
        found = FareFound.new
        found.search_fare_id = search_fare_id
        found.time = clock.iso8601
        found.processed_time = clock.iso8601
        found.metadata.follow(found_one_of_the_fares.metadata)
        write.(found, stream_name)
      end
    end
  end
end
