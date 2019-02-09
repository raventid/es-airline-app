module PaymentTerminalComponent
  module Messages
    module Events
      class BestPriceFound
        include Messaging::Message

        attribute :profit_planner_id, String
        attribute :payment_terminal_id, String
        attribute :time, String
        attribute :processed_time, String
        attribute :amount, String
        attribute :currency_code, String
        attribute :gateway_name, String
        attribute :profit, String
      end
    end
  end
end
