# Component initiator user guide: http://docs.eventide-project.org/user-guide/component-host.html#component-initiator

module BookTicketComponent
  module Start
    def self.call
      Consumers::Commands.start('bookTicket:command')
      Consumers::Events.start('bookTicket')

      correlation_condition = "metadata->>'correlationStreamName' LIKE 'bookTicket-%'"
      Consumers::Wolfgang::Events.start('wolfgang', condition: correlation_condition)
      Consumers::Charters::Events.start('charters', condition: correlation_condition)
    end
  end
end
