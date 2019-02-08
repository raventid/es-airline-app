module WolfgangComponent
  module Messages
    module Commands
      class BookTicket
        include Messaging::Message

        attribute :wolfgang_id, String
        attribute :part, String
        attribute :time, String
      end
    end
  end
end
