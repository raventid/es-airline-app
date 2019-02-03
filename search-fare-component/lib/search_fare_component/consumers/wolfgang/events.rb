module SearchFareComponent
  module Consumers
    module Wolfgang
      class Events
        include Consumer::Postgres

        identifier 'searchFare'

        handler Handlers::Wolfgang::Events
      end
    end
  end
end
