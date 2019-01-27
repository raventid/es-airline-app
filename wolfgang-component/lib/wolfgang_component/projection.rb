# Projection user guide: http://docs.eventide-project.org/user-guide/projection.html
# Message user guide: http://docs.eventide-project.org/user-guide/messages-and-message-data/

module WolfgangComponent
  class Projection
    include EntityProjection
    # TODO include Messages::Events once events are implemented"
    # include Messages::Events

    entity_name :wolfgang

    # TODO Implement event projection blocks
    # eg:
    # apply SomethingHappened do |something_happened|
    #   SetAttributes.(wolfgang, something_happened, copy: [
    #     { :wolfgang_id => :id }
    #   ])

    #   something_happened_time = Clock.parse(something_happened.time)

    #   wolfgang.something_happened_time = something_happened_time
    # end
  end
end
