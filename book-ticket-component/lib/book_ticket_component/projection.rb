# Projection user guide: http://docs.eventide-project.org/user-guide/projection.html
# Message user guide: http://docs.eventide-project.org/user-guide/messages-and-message-data/

module BookTicketComponent
  class Projection
    include EntityProjection
    include Messages::Events

    entity_name :book_ticket

    apply InitiatedBookTicket do |initiated_book_ticket|
      book_ticket.register_flight_parts(initiated_book_ticket.request)
    end

    apply OneOfTheTicketsBooked do |one_of_the_tickets_booked|
      book_ticket.register_ticket_for(one_of_the_tickets_booked.part, one_of_the_tickets_booked.data[:prices])
    end
  end
end
