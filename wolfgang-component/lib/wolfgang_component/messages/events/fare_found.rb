module WolfgangComponent
  module Messages
    module Events
      class FareFound
        include Messaging::Message

        attribute :wolfgang_id, String
        attribute :time, String
        attribute :processed_time, String
        attribute :sequence, Integer
        attribute :data, Hash
      end
    end
  end
end
