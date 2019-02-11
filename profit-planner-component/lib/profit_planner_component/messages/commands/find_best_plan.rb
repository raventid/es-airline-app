module FindBestPlan
  module Messages
    module Commands
      class FindBestPlan
        include Messaging::Message

        attribute :profit_planner_id, String
        attribute :amount, String
        attribute :currency_code, String
      end
    end
  end
end
