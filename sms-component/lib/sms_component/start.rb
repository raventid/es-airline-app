# Component initiator user guide: http://docs.eventide-project.org/user-guide/component-host.html#component-initiator

module SmsComponent
  module Start
    def self.call
      Consumers::Commands.start('sms:command')
      Consumers::Events.start('sms')
    end
  end
end
