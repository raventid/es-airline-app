module BookTicketComponent
  module Messages
    module Events
      class OneOfTheTicketsBooked
        include Messaging::Message

        attribute :book_ticket_id, String
        attribute :time, String
        attribute :part, String
        attribute :processed_time, String
        attribute :data, Hash
      end
    end
  end
end
