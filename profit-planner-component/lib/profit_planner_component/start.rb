# Component initiator user guide: http://docs.eventide-project.org/user-guide/component-host.html#component-initiator

module ProfitPlannerComponent
  module Start
    def self.call
      Consumers::Commands.start('profitPlanner:command')
      Consumers::Events.start('profitPlanner')
    end
  end
end
