module WolfgangComponent
  module Messages
    module Commands
      class FindFare
        include Messaging::Message

        attribute :wolfgang_id, String
        attribute :part, String
        attribute :time, String
      end
    end
  end
end
