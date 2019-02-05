module SearchFareComponent
  module Consumers
    module Charters
      class Events
        include Consumer::Postgres

        identifier 'searchFare'

        handler Handlers::Charters::Events
      end
    end
  end
end
