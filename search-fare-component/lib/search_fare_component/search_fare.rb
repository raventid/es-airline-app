# Entity user guide: http://docs.eventide-project.org/user-guide/entities.html
# Entity snapshotting user guide: http://docs.eventide-project.org/user-guide/entity-store/snapshotting.html

module SearchFareComponent
  class SearchFare
    include Schema::DataStructure

    # Internal class for flight_part
    class FlightPart
      attr_reader :cities
      attr_accessor :fare

      def initialize(cities)
        @cities = cities
      end
    end

    attribute :id, String
    attribute :flight_parts, FlightPart

    # TODO Implement attributes
    # TODO Implement entity logic, predicates, mutations, calculations, etc
    # Note: This class's methods should pertain only to its attributes
    def register_flight_parts(flight_parts)
      self.flight_parts = flight_parts
    end

    # Next step in state machine. Update the part we got information about.
    def register_fare_for(flight_part, fare)
      part = self.flight_parts.find { |part| part.cities == flight_part.cities }
      part.fare = fare
    end

    # Fare found for every required part of flight.
    # So it's a final state for our state machine.
    def fare_found?
      self.flight_parts.all do |part|
        part.fare_found?
      end
    end
  end
end
