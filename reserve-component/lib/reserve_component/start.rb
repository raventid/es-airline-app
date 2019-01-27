# Component initiator user guide: http://docs.eventide-project.org/user-guide/component-host.html#component-initiator

module ReserveComponent
  module Start
    def self.call
      Consumers::Commands.start('reserve:command')
      Consumers::Events.start('reserve')
    end
  end
end
