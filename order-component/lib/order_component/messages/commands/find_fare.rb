module OrderComponent
  module Messages
    module Commands
      class FindFare
        include Messaging::Message

        attribute :order_id, String
      end
    end
  end
end
