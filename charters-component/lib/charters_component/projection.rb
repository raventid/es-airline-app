# Projection user guide: http://docs.eventide-project.org/user-guide/projection.html
# Message user guide: http://docs.eventide-project.org/user-guide/messages-and-message-data/

module ChartersComponent
  class Projection
    include EntityProjection
    # TODO include Messages::Events once events are implemented"
    include Messages::Events

    entity_name :charters

    apply FareFound do |fare_found|
      charters.id = fare_found.charters_id
      charters.sequence = fare_found.sequence
    end
    # TODO Implement event projection blocks
    # eg:
    # apply SomethingHappened do |something_happened|
    #   SetAttributes.(charters, something_happened, copy: [
    #     { :charters_id => :id }
    #   ])

    #   something_happened_time = Clock.parse(something_happened.time)

    #   charters.something_happened_time = something_happened_time
    # end
  end
end
