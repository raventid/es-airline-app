# Consumer user guide: http://docs.eventide-project.org/user-guide/consumers.html

module BookTicketComponent
  module Consumers
    class Commands
      include Consumer::Postgres

      handler Handlers::Commands
    end
  end
end
