module SearchFareComponent
  module Messages
    module Events
      class FoundOneOfTheFares
        include Messaging::Message

        attribute :search_fare_id, String
        attribute :time, String
        attribute :processed_time, String
        attribute :data, String
      end
    end
  end
end
