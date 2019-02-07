module BookTicketComponent
  module Handlers
    module Wolfgang
      class Events
        include Log::Dependency
        include Messaging::Handle
        include Messaging::StreamName
        include Messages::Events

        dependency :write, Messaging::Postgres::Write
        dependency :clock, Clock::UTC
        dependency :store, Store
        dependency :identifier, Identifier::UUID::Random

        def configure
          Messaging::Postgres::Write.configure(self)
          Clock::UTC.configure(self)
          Store.configure(self)
          Identifier::UUID::Random.configure(self)
        end

        category :book_ticket

        handle ::Wolfgang::Client::Messages::Events::TicketBooked do |fare_found|
          correlation_stream_name = fare_found.metadata.correlation_stream_name
          book_ticket_id = Messaging::StreamName.get_id(correlation_stream_name)

          logger.info("I RECEIVED FARE FOUND FROM GDS!!! book_ticket_id: #{book_ticket_id}")

          book_ticket, version = store.fetch(book_ticket_id, include: :version)
          # Here we use correlation stream, we are waiting
          # for Wolfgang fare_found or Wolfgang
          # TODO: Wait for Wolfgang to return FareNotFound

          # TODO: Implement correct correlation logic.

          # This event is potentially will be ignored.
          # So it's just a marker event.
          # Still it might be usefull for debugging and coordination.

          # TODO How should fare found work?
          # Just collect some data in fare_found.
          stream_name = stream_name(book_ticket_id)

          logger.info("ISSUING FOUND_ONE_OF_THE_FARES with book_ticket_id: #{book_ticket_id}")

          found_one_of_the_fares  = OneOfTheTicketsBooked.new
          found_one_of_the_fares.book_ticket_id = book_ticket_id
          found_one_of_the_fares.part = fare_found.part
          found_one_of_the_fares.data = fare_found.data
          found_one_of_the_fares.metadata.follow(fare_found.metadata)
          found_one_of_the_fares.processed_time = clock.iso8601
          write.(found_one_of_the_fares, stream_name)
        end
      end
    end
  end
end
