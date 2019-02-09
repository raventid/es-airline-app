module PaymentTerminalComponent
  module Messages
    module Commands
      class FindBestPrice
        include Messaging::Message

        attribute :profit_planner_id, String
        attribute :payment_terminal_id, String
        attribute :time, String
        attribute :amount, String
        attribute :currency_code, String
      end
    end
  end
end
