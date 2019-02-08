# Handler user guide: http://docs.eventide-project.org/user-guide/handlers.html
# Message user guide: http://docs.eventide-project.org/user-guide/messages-and-message-data/

module BookTicketComponent
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

      category :book_ticket

      handle InitiatedBookTicket do |initiated|
        # We initiated the search
        #
        # 1. register_flight_parts in entity
        book_ticket_id = initiated.book_ticket_id
        book_ticket, version = store.fetch(book_ticket_id, include: :version)

        # 2. Iterate over request and get flight parts
        commands = initiated.request.map do |key, value|
          # 3. Get gds name
          gds_name = value[:gds]

          # 4. Issue command for every GDS gateway.
          id = Identifier::UUID::Random.get # Here should be `gds`-generator
          book_ticket = ::Object.const_get(gds_name.capitalize)::Client::Messages::Commands::BookTicket.new
          book_ticket.part = key.to_s # part is a key
          book_ticket.metadata.follow(initiated.metadata)
          book_ticket.send("#{gds_name}_id=", id) # Here should be `gds_name`_id
          book_ticket.time = '2000-01-01T11:11:11.000Z' # better way?

          command_stream_name = "#{gds_name}:command-#{id}" # how to incapsulate?

          # 5. wrap every part with command
          # TODO: There's no possibility to stub this message right now
          # we should made an object command in Wolfgang and import it here.
          # So we can register it as dependency and run isolated tests.

          write.(book_ticket, command_stream_name)
        end
      end

      handle OneOfTheTicketsBooked do |one_of_the_tickets_booked|
        logger.info("Handle ONE_OF_THE_TICKETS_BOOKED book_ticket_id: #{book_ticket_id}")

        book_ticket_id = one_of_the_tickets_booked.book_ticket_id
        book_ticket, version = store.fetch(book_ticket_id, include: :version)

        # Do not reissue TicketBooked final event.:shrug:

        # Catch every FoundOneOfTheFares event.
        # If we already found all of the fares for current book_ticket, then
        # we can issue our terminating event - FareFound.
        return if !book_ticket.every_ticket_booked? || book_ticket.completed?

        stream_name = stream_name(book_ticket_id)

        logger.info("Every ticket booked. Event processed (Command: #{one_of_the_tickets_booked.message_type}, BookTicket ID: #{book_ticket_id})")

        found = TicketBooked.new
        found.book_ticket_id = book_ticket_id
        found.time = clock.iso8601
        found.processed_time = clock.iso8601
        found.metadata.follow(one_of_the_tickets_booked.metadata)
        write.(found, stream_name)
      end
    end
  end
end
