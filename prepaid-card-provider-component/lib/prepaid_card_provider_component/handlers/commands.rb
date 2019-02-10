# Handler user guide: http://docs.eventide-project.org/user-guide/handlers.html
# Message user guide: http://docs.eventide-project.org/user-guide/messages-and-message-data/

module PrepaidCardProviderComponent
  module Handlers
    class Commands
      include Messaging::Handle
      include Messaging::StreamName
      include Log::Dependency
      include Messages::Commands
      include Messages::Events

      dependency :write, Messaging::Postgres::Write
      dependency :clock, Clock::UTC
      dependency :store, Store

      def configure
        Messaging::Postgres::Write.configure(self)
        Clock::UTC.configure(self)
        Store.configure(self)
      end

      category :prepaid_card_provider

      handle CalculatePrepaidCardProfit do |calculate_prepaid_card_profit|
        logger.info("Handler received")

        prepaid_card_provider_id = calculate_prepaid_card_profit.prepaid_card_provider_id

        prepaid_card_provider, version = store.fetch(prepaid_card_provider_id, include: :version)

        profit_calculated = PrepaidCardProfitCalculated.follow(calculate_prepaid_card_profit)

        profit_calculated.amount = "100"

        profit_calculated.currency_code = "EUR"

        profit_calculated.processed_time = clock.iso8601

        stream_name = stream_name(prepaid_card_provider_id)

        write.(profit_calculated, stream_name, expected_version: version)
      end
    end
  end
end
