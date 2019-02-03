module SearchFareComponent
  module Messages
    module Events
      class InitiatedFindFare
        include Messaging::Message

        attribute :search_fare_id, String
        attribute :time, String
        attribute :request, Hash # Command.follow() will try to copy this field from previous command and if this field does not exists it will blow up. So we need this one here to work with events.
        attribute :processed_time, String
      end
    end
  end
end
