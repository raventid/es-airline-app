module PrepaidCardProviderComponent
  module Messages
    module Commands
      class CalculatePrepaidCardProfit
        include Messaging::Message

        attribute :prepaid_card_provider_id, String
        attribute :profit_planner_id, String
        attribute :time, String
        attribute :amount, String
        attribute :currency_code, String
      end
    end
  end
end
