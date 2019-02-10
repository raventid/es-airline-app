module ProfitPlannerComponent
  module Messages
    module Events
      class BestPlanFound
        include Messaging::Message

        attribute :profit_planner_id, String
        attribute :gateway_name, String
      end
    end
  end
end
