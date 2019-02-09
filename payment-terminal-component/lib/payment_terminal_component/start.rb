# Component initiator user guide: http://docs.eventide-project.org/user-guide/component-host.html#component-initiator

module PaymentTerminalComponent
  module Start
    def self.call
      Consumers::Commands.start('paymentTerminal:command')
      Consumers::Events.start('paymentTerminal')
    end
  end
end
