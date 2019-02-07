module BookTicketComponent
  module Messages
    module Events
      class TicketBooked
        include Messaging::Message

        attribute :book_ticket_id, String
        attribute :time, String
        attribute :processed_time, String
      end
    end
  end
end
