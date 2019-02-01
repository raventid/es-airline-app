module SearchFareComponent
  module Messages
    module Commands
      class FindFare
        include Messaging::Message

        attribute :search_fare_id, String
        attribute :search_part, String
        attribute :request, Hash # meeeeeh, should be [("mow-led", "galileo"), ("led-par", "sirena"), ("par-lon", "sita")]
        attribute :time, String
      end
    end
  end
end
