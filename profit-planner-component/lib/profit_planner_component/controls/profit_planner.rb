module ProfitPlannerComponent
  module Controls
    module ProfitPlanner
      def self.example
        profit_planner = ProfitPlannerComponent::ProfitPlanner.build

        profit_planner.id = self.id
        profit_planner.something_happened_time = Time::Effective::Raw.example

        profit_planner
      end

      def self.id
        ID.example(increment: id_increment)
      end

      def self.id_increment
        1111
      end

      module New
        def self.example
          ProfitPlannerComponent::ProfitPlanner.build
        end
      end

      module Identified
        def self.example
          profit_planner = New.example
          profit_planner.id = ProfitPlanner.id
          profit_planner
        end
      end
    end
  end
end
