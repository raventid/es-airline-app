module OrderComponent
  module FareFound
    module Events
      class FareFound
        include Messaging::Message

        attribute :order_id, String
        attribute :search_fare_id, String
      end
    end
  end
end
