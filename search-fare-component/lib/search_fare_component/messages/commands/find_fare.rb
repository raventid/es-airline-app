module SearchFareComponent
  module Messages
    module Commands
      class FindFare
        include Messaging::Message

        attribute :search_fare_id, String
        attribute :search_part, String
        attribute :gds, String
        attribute :time, String
      end
    end
  end
end
