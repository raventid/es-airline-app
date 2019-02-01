module SearchFareComponent
  module Messages
    module Events
      class InitiatedFindFare
        include Messaging::Message

        attribute :search_fare_id, String
        attribute :time, String
        attribute :processed_time, String
      end
    end
  end
end
