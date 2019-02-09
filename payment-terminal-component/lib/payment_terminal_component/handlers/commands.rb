# Handler user guide: http://docs.eventide-project.org/user-guide/handlers.html
# Message user guide: http://docs.eventide-project.org/user-guide/messages-and-message-data/

module PaymentTerminalComponent
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

      category :payment_terminal

      handle FindBestPrice do |find_best_price|
        payment_terminal_id = find_best_price.payment_terminal_id

        payment_terminal, version = store.fetch(payment_terminal_id, include: :version)

        logger.info("Command ignored (Command: #{find_best_price.message_type}, PaymentTerminal ID: #{payment_terminal_id})")

        best_price_found = BestPriceFound.follow(find_best_price)

        best_price_found.gateway_name = "default_gateway"

        best_price_found.profit = "100"

        best_price_found.processed_time = clock.iso8601

        stream_name = stream_name(payment_terminal_id)

        write.(best_price_found, stream_name, expected_version: version)
      end
    end
  end
end
