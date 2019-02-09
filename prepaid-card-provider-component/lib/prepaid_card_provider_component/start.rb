# Component initiator user guide: http://docs.eventide-project.org/user-guide/component-host.html#component-initiator

module PrepaidCardProviderComponent
  module Start
    def self.call
      Consumers::Commands.start('prepaidCardProvider:command')
      Consumers::Events.start('prepaidCardProvider')
    end
  end
end
