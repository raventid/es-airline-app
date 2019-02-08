# Entity user guide: http://docs.eventide-project.org/user-guide/entities.html
# Entity snapshotting user guide: http://docs.eventide-project.org/user-guide/entity-store/snapshotting.html

module SearchFareComponent
  class SearchFare
    include Schema::DataStructure

    # TODO: More classes, no Hash, please.

    # flight_parts structure is the next one:
    # "mow-led": {
    #   gds: wolfgang,
    #   received: true
    # }

    attribute :id, String
    attribute :flight_parts, Hash
    attribute :completed, Boolean

    # TODO Implement attributes
    # TODO Implement entity logic, predicates, mutations, calculations, etc
    # Note: This class's methods should pertain only to its attributes

    # This method registers all of the flight_parts we need to search_fare for.
    def register_flight_parts(flight_parts)
      # We should not use ||= here.
      # `register_flight_parts` should only be called in InitiatedFindFare
      self.flight_parts = {}

      flight_parts.each do |k,v|
        self.flight_parts[k] = {
          gds: v[:gds], # what gds is requested for this search_fare
          received: false
        }
      end

      self.completed = false
    end

    # Next step in state machine. Update the part we got information about.
    def register_fare_for(part, fare)
      self.flight_parts[part.to_sym][:received] = true
    end

    # Fare found for every required part of flight.
    # So it's a final state for our state machine.
    def fare_found?
      # TODO: VERY BAD CHECK DETECTED
      return false if !self.flight_parts

      self.flight_parts.all? do |k,v|
        v[:received]
      end
    end

    def completed?
      self.completed
    end
  end
end
