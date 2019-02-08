# Handler user guide: http://docs.eventide-project.org/user-guide/handlers.html
# Message user guide: http://docs.eventide-project.org/user-guide/messages-and-message-data/

module BookTicketComponent
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

      category :book_ticket

      handle BookTicketM do |book_ticket|
        book_ticket_id = book_ticket.book_ticket_id

        book_ticket_entity, version = store.fetch(book_ticket_id, include: :version)

        logger.info("BookTicketM Received, issue InitiatedBookTicket")

        initiated_book_ticket = InitiatedBookTicket.follow(book_ticket)
        initiated_book_ticket.processed_time = clock.iso8601
        stream_name = stream_name(book_ticket_id)
        initiated_book_ticket.metadata.correlation_stream_name = stream_name
        write.(initiated_book_ticket, stream_name, expected_version: version)
      end
    end
  end
end
