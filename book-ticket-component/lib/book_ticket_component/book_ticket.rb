# Entity user guide: http://docs.eventide-project.org/user-guide/entities.html
# Entity snapshotting user guide: http://docs.eventide-project.org/user-guide/entity-store/snapshotting.html

module BookTicketComponent
  class BookTicket
    include Schema::DataStructure

    # TODO: More classes, no Hash, please.

    # flight_parts structure is the next one:
    # "mow-led": {
    #   gds: wolfgang,
    #   received: true
    # }

    attribute :id, String
    attribute :flight_parts, Hash

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
    end

    # Next step in state machine. Update the part we got information about.
    def register_fare_for(part, fare)
      self.flight_parts[part.to_sym][:received] = true
    end

    # Fare found for every required part of flight.
    # So it's a final state for our state machine.
    def fare_found?
      self.flight_parts.all? do |k,v|
        v[:received]
      end
    end
  end
end
