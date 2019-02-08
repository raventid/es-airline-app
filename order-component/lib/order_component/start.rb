# Component initiator user guide: http://docs.eventide-project.org/user-guide/component-host.html#component-initiator

module OrderComponent
  module Start
    def self.call
      Consumers::Commands.start('order:command')
      Consumers::Events.start('order')
    end
  end
end
