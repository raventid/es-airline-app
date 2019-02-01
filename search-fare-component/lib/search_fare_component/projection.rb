# Projection user guide: http://docs.eventide-project.org/user-guide/projection.html
# Message user guide: http://docs.eventide-project.org/user-guide/messages-and-message-data/

module SearchFareComponent
  class Projection
    include EntityProjection
    # TODO include Messages::Events once events are implemented"
    include Messages::Events

    entity_name :search_fare

    # TODO Implement event projection blocks
    # eg:
    # apply SomethingHappened do |something_happened|
    #   SetAttributes.(search_fare, something_happened, copy: [
    #     { :search_fare_id => :id }
    #   ])

    #   something_happened_time = Clock.parse(something_happened.time)

    #   search_fare.something_happened_time = something_happened_time
    # end
    apply FoundOneOfTheFares do |found_one_of_the_fares|
      # Follow sequence.
      search_fare.sequence = found_one_of_the_fares.sequence

      # Register fare found for particular entity.
      search_fare.register_part(found_one_of_the_fares.part, found_one_of_the_fares.fare_info)
    end
  end
end
