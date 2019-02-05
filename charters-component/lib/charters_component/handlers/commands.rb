# Handler user guide: http://docs.eventide-project.org/user-guide/handlers.html
# Message user guide: http://docs.eventide-project.org/user-guide/messages-and-message-data/
require_relative "../../../../global_config"

module ChartersComponent
  module Handlers
    class Commands
      include Messaging::Handle
      include Messaging::StreamName
      include Log::Dependency
      # TODO include Messages::Commands once commands are implemented
      include Messages::Commands
      # TODO include Messages::Events once commands are implemented"
      include Messages::Events

      dependency :write, Messaging::Postgres::Write
      dependency :clock, Clock::UTC
      dependency :store, Store

      def configure
        Messaging::Postgres::Write.configure(self)
        Clock::UTC.configure(self)
        Store.configure(self)
      end

      category :charters

      # TODO Implement command handler blocks
      # eg:
      # handle DoSomething do |do_something|
      #   charters_id = do_something.charters_id

      #   charters, version = store.fetch(charters_id, include: :version)

      #   if charters.something_happened?
      #     logger.info(tag: :ignored) { "Command ignored (Command: #{do_something.message_type}, Charters ID: #{charters_id})" }
      #     return
      #   end

      #   something_happened = SomethingHappened.follow(do_something)

      #   something_happened.processed_time = clock.iso8601

      #   stream_name = stream_name(charters_id)

      #   write.(something_happened, stream_name, expected_version: version)
      # end
      handle FindFare do |find_fare|
        charters_id = find_fare.charters_id

        # # skip idempotence protections
        charters = store.fetch(charters_id)
        sequence = find_fare.metadata.global_position
        if charters.processed?(sequence)
          return
        end

        logger.info("dsadasdasadasdasdsdsaaddsddssdsakjjdfahahakh")

        fare_found = FareFound.follow(find_fare)
        fare_found.time = "2000-01-01T11:11:11.000Z" # should it be the time from a command?
        fare_found.processed_time = "2000-01-01T11:11:11.000Z"
        fare_found.sequence = sequence

        fare_found.data = JSON.parse(Faraday.get("http://localhost:#{CHARTERS_SERVER_APP_PORT}/search_fare").body)

        stream_name = stream_name(charters_id)

        write.(fare_found, stream_name)

        # # search_fare_response = run_external_idepotent_search_fare_request(find_fare.req_payload)

        # # if fare is successfully found
        # if search_fare_response.success? && search_fare_response.prices
        #   fare_found = FareFound.follow(find_fare)
        #   write.(fare_found, stream_name)
        # end

        # # if fare is not found at all
        # if !search_fare_response.success?
        #   fare_not_found = FareNotFound.follow(find_fare)
        #   write.(fare_not_found, stream_name)
        # end

        # Both of the messages above are also handled by search-fare-component.
        #
        #
        #

        # timeouts?
        # internal response (bad xml parsing, credentials mistake)
      end
    end
  end
end
