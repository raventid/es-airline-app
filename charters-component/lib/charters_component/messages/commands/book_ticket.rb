module ChartersComponent
  module Messages
    module Commands
      class BookTicket
        include Messaging::Message

        attribute :charters_id, String
        attribute :part, String
        attribute :time, String
      end
    end
  end
end
