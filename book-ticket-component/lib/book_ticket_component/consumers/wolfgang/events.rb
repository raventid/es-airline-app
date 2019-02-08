module BookTicketComponent
  module Consumers
    module Wolfgang
      class Events
        include Consumer::Postgres

        identifier 'bookTicket'

        handler Handlers::Wolfgang::Events
      end
    end
  end
end
