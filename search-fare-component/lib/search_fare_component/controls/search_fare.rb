module SearchFareComponent
  module Controls
    module SearchFare
      def self.example
        search_fare = SearchFareComponent::SearchFare.build

        search_fare.id = self.id
        search_fare.something_happened_time = Time::Effective::Raw.example

        search_fare
      end

      def self.id
        ID.example(increment: id_increment)
      end

      def self.id_increment
        1111
      end

      module New
        def self.example
          SearchFareComponent::SearchFare.build
        end
      end

      module Identified
        def self.example
          search_fare = New.example
          search_fare.id = SearchFare.id
          search_fare
        end
      end
    end
  end
end
