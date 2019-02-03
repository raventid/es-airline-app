# Component initiator user guide: http://docs.eventide-project.org/user-guide/component-host.html#component-initiator

module SearchFareComponent
  module Start
    def self.call
      # Consumers for SearchFareComponent
      Consumers::Commands.start('searchFare:command')
      Consumers::Events.start('searchFare')

      # Consumers for WolfgangComponent
      correlation_condition = "metadata->>'correlationStreamName' LIKE 'searchFare-%'"
      Consumers::Wolfgang::Events.start('wolfgang', condition: correlation_condition)
    end
  end
end
