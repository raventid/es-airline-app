# Component initiator user guide: http://docs.eventide-project.org/user-guide/component-host.html#component-initiator

module EmailComponent
  module Start
    def self.call
      Consumers::Commands.start('email:command')
      Consumers::Events.start('email')
    end
  end
end
