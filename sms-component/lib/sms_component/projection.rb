# Projection user guide: http://docs.eventide-project.org/user-guide/projection.html
# Message user guide: http://docs.eventide-project.org/user-guide/messages-and-message-data/

module SmsComponent
  class Projection
    include EntityProjection
    # TODO include Messages::Events once events are implemented"
    # include Messages::Events

    entity_name :sms

    # TODO Implement event projection blocks
    # eg:
    # apply SomethingHappened do |something_happened|
    #   SetAttributes.(sms, something_happened, copy: [
    #     { :sms_id => :id }
    #   ])

    #   something_happened_time = Clock.parse(something_happened.time)

    #   sms.something_happened_time = something_happened_time
    # end
  end
end
