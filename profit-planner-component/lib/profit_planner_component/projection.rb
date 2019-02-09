# Projection user guide: http://docs.eventide-project.org/user-guide/projection.html
# Message user guide: http://docs.eventide-project.org/user-guide/messages-and-message-data/

module ProfitPlannerComponent
  class Projection
    include EntityProjection
    # TODO include Messages::Events once events are implemented"
    # include Messages::Events

    entity_name :profit_planner

    # TODO Implement event projection blocks
    # eg:
    # apply SomethingHappened do |something_happened|
    #   SetAttributes.(profit_planner, something_happened, copy: [
    #     { :profit_planner_id => :id }
    #   ])

    #   something_happened_time = Clock.parse(something_happened.time)

    #   profit_planner.something_happened_time = something_happened_time
    # end
  end
end
