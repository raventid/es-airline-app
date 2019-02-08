module BookTicketComponent
  module Handlers
    module Charters
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

        # Same code will be written for every GDS gateway.
        # Potentially This gateway component BookTicketComponent
        # could be an interactor step for us, which works directly with
        # gds events.
        handle ::Charters::Client::Messages::Events::TicketBooked do |fare_found|
          correlation_stream_name = fare_found.metadata.correlation_stream_name
          book_ticket_id = Messaging::StreamName.get_id(correlation_stream_name)

          logger.info("I RECEIVED FARE FOUND FROM GDS!!! book_ticket_id: #{book_ticket_id}")

          book_ticket, version = store.fetch(book_ticket_id, include: :version)
          stream_name = stream_name(book_ticket_id)

          logger.info("ISSUING FOUND_ONE_OF_THE_FARES with book_ticket_id: #{book_ticket_id}")

          one_of_the_tickets_booked  = OneOfTheTicketsBooked.new
          one_of_the_tickets_booked.book_ticket_id = book_ticket_id
          one_of_the_tickets_booked.part = fare_found.part
          one_of_the_tickets_booked.data = fare_found.data
          one_of_the_tickets_booked.metadata.follow(fare_found.metadata)
          one_of_the_tickets_booked.processed_time = clock.iso8601
          write.(one_of_the_tickets_booked, stream_name)
        end
      end
    end
  end
end
