# Component initiator user guide: http://docs.eventide-project.org/user-guide/component-host.html#component-initiator

module ChartersComponent
  module Start
    def self.call
      Consumers::Commands.start('charters:command', position_update_interval: 100)
      Consumers::Events.start('charters')
    end
  end
end
