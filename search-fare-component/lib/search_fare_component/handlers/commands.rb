# Handler user guide: http://docs.eventide-project.org/user-guide/handlers.html
# Message user guide: http://docs.eventide-project.org/user-guide/messages-and-message-data/

module SearchFareComponent
  module Handlers
    class Commands
      include Messaging::Handle
      include Messaging::StreamName
      include Log::Dependency
      include Messages::Commands
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

      # TODO Implement command handler blocks"
      # eg:
      # handle DoSomething do |do_something|
      #   search_fare_id = do_something.search_fare_id

      #   search_fare, version = store.fetch(search_fare_id, include: :version)

      #   if search_fare.something_happened?
      #     logger.info(tag: :ignored) { "Command ignored (Command: #{do_something.message_type}, SearchFare ID: #{search_fare_id})" }
      #     return
      #   end

      #   something_happened = SomethingHappened.follow(do_something)

      #   something_happened.processed_time = clock.iso8601

      #   stream_name = stream_name(search_fare_id)

      #   write.(something_happened, stream_name, expected_version: version)
      # end
      handle FindFare do |find_fare|
        # Potential point for command validation.

        # dry-validation hell goes here! Or dry-schema!

        search_fare_id = find_fare.search_fare_id

        search_fare_entity, version = store.fetch(search_fare_id, include: :version)

        # TODO How should fare found work?
        # Just collect some data in fare_found.
        if search_fare_entity.fare_found?
          logger.info("Command ignored (Command: #{find_fare.message_type}, SearchFare ID: #{search_fare_id})")
          return
        end

        # Register every part, impossible here?
        # search_fare_entity.register_flight_parts(search_fare.flight_parts)


        # For each flight part issue a command for every vendor service.
        # search_fare.flight_parts.each do |part|
            # stream_name = stream_name(part.gds)
            # command = GDS::SeachFare.follow(search_fare)
            # impossible to write command here
            # write.(command, stream_name, expected_version: version) # cannot use this pattern here
        # end
        #
        #

        logger.info("FindFare Received, issue InitiatedFindFare")

        initiated_find_fare = InitiatedFindFare.follow(find_fare)

        initiated_find_fare.processed_time = clock.iso8601

        stream_name = stream_name(search_fare_id)

        initiated_find_fare.metadata.correlation_stream_name = stream_name

        write.(initiated_find_fare, stream_name, expected_version: version)
      end
    end
  end
end
