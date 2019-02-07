# Handler user guide: http://docs.eventide-project.org/user-guide/handlers.html
# Message user guide: http://docs.eventide-project.org/user-guide/messages-and-message-data/
require_relative "../../../../global_config"

module ChartersComponent
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

      category :charters

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
      end

      handle BookTicket do |find_fare|
        charters_id = find_fare.charters_id

        # # skip idempotence protections
        charters = store.fetch(charters_id)
        sequence = find_fare.metadata.global_position
        if charters.processed?(sequence)
          return
        end

        logger.info("dsadasdasadasdasdsdsaaddsddssdsakjjdfahahakh")

        fare_found = TicketBooked.follow(find_fare)
        fare_found.time = "2000-01-01T11:11:11.000Z" # should it be the time from a command?
        fare_found.processed_time = "2000-01-01T11:11:11.000Z"
        fare_found.sequence = sequence

        fare_found.data = JSON.parse(Faraday.get("http://localhost:#{CHARTERS_SERVER_APP_PORT}/search_fare").body)

        stream_name = stream_name(charters_id)

        write.(fare_found, stream_name)
      end
    end
  end
end
