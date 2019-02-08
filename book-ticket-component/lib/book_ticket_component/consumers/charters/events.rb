module BookTicketComponent
  module Consumers
    module Charters
      class Events
        include Consumer::Postgres

        identifier 'bookTicket'

        handler Handlers::Charters::Events
      end
    end
  end
end
