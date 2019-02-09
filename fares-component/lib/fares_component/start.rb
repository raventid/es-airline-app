# Component initiator user guide: http://docs.eventide-project.org/user-guide/component-host.html#component-initiator

module FaresComponent
  module Start
    def self.call
      Consumers::Commands.start('fares:command')
      Consumers::Events.start('fares')
    end
  end
end
