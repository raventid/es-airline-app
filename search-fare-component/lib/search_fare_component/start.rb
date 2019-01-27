# Component initiator user guide: http://docs.eventide-project.org/user-guide/component-host.html#component-initiator

module SearchFareComponent
  module Start
    def self.call
      Consumers::Commands.start('searchFare:command')
      Consumers::Events.start('searchFare')
    end
  end
end
