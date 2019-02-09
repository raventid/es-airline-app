# Handler user guide: http://docs.eventide-project.org/user-guide/handlers.html
# Message user guide: http://docs.eventide-project.org/user-guide/messages-and-message-data/

module FaresComponent
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

      category :fares

      # TODO Implement command handler blocks"
      # eg:
      # handle DoSomething do |do_something|
      #   fares_id = do_something.fares_id

      #   fares, version = store.fetch(fares_id, include: :version)

      #   if fares.something_happened?
      #     logger.info(tag: :ignored) { "Command ignored (Command: #{do_something.message_type}, Fares ID: #{fares_id})" }
      #     return
      #   end

      #   something_happened = SomethingHappened.follow(do_something)

      #   something_happened.processed_time = clock.iso8601

      #   stream_name = stream_name(fares_id)

      #   write.(something_happened, stream_name, expected_version: version)
      # end
    end
  end
end
