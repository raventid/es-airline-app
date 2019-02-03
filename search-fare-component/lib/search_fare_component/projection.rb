# Projection user guide: http://docs.eventide-project.org/user-guide/projection.html
# Message user guide: http://docs.eventide-project.org/user-guide/messages-and-message-data/

module SearchFareComponent
  class Projection
    include EntityProjection
    include Messages::Events

    entity_name :search_fare

    apply InitiatedFindFare do |initiated_find_fare|
      # Register all of the search part I have to work with.
      search_fare.register_flight_parts(initiated_find_fare.request)
    end

    apply FoundOneOfTheFares do |found_one_of_the_fares|
      # Follow sequence. Protection from reprocessing commands.
      # search_fare.sequence = found_one_of_the_fares.sequence

      # Register fare found for particular entity.
      search_fare.register_fare_for(found_one_of_the_fares.part, found_one_of_the_fares.data[:prices])
    end
  end
end
