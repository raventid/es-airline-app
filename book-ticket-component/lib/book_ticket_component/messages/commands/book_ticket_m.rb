module BookTicketComponent
  module Messages
    module Commands
      class BookTicketM
        include Messaging::Message

        attribute :book_ticket_id, String
        attribute :request, Hash # meeeeeh, should be [("mow-led", "galileo"), ("led-par", "sirena"), ("par-lon", "sita")]
        attribute :time, String
      end
    end
  end
end
