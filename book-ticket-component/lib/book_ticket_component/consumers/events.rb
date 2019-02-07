# Consumer user guide: http://docs.eventide-project.org/user-guide/consumers.html

module BookTicketComponent
  module Consumers
    class Events
      include Consumer::Postgres

      handler Handlers::Events
    end
  end
end
