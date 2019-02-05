module ChartersComponent
  module Messages
    module Events
      class FareFound
        include Messaging::Message

        attribute :charters_id, String
        attribute :time, String
        attribute :part, String
        attribute :processed_time, String
        attribute :sequence, Integer
        attribute :data, Hash
      end
    end
  end
end
