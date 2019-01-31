# Component initiator user guide: http://docs.eventide-project.org/user-guide/component-host.html#component-initiator

module WolfgangComponent
  module Start
    def self.call
      Consumers::Commands.start('wolfgang:command', position_update_interval: 100)
      Consumers::Events.start('wolfgang')
    end
  end
end
