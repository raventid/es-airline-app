# Handler user guide: http://docs.eventide-project.org/user-guide/handlers.html
# Message user guide: http://docs.eventide-project.org/user-guide/messages-and-message-data/

module PaymentTerminalComponent
  module Handlers
    class Commands
      include Messaging::Handle
      include Messaging::StreamName
      include Log::Dependency
      # TODO include Messages::Commands once commands are implemented
      # include Messages::Commands
      # TODO include Messages::Events once commands are implemented"
      # include Messages::Events

      dependency :write, Messaging::Postgres::Write
      dependency :clock, Clock::UTC
      dependency :store, Store

      def configure
        Messaging::Postgres::Write.configure(self)
        Clock::UTC.configure(self)
        Store.configure(self)
      end

      category :payment_terminal

      # TODO Implement command handler blocks"
      # eg:
      # handle DoSomething do |do_something|
      #   payment_terminal_id = do_something.payment_terminal_id

      #   payment_terminal, version = store.fetch(payment_terminal_id, include: :version)

      #   if payment_terminal.something_happened?
      #     logger.info(tag: :ignored) { "Command ignored (Command: #{do_something.message_type}, PaymentTerminal ID: #{payment_terminal_id})" }
      #     return
      #   end

      #   something_happened = SomethingHappened.follow(do_something)

      #   something_happened.processed_time = clock.iso8601

      #   stream_name = stream_name(payment_terminal_id)

      #   write.(something_happened, stream_name, expected_version: version)
      # end
    end
  end
end
