module SearchFareComponent
  module Handlers
    module Wolfgang
      class Events
        include Log::Dependency
        include Messaging::Handle
        include Messaging::StreamName
        include Messages::Events

        dependency :write, Messaging::Postgres::Write
        dependency :clock, Clock::UTC
        dependency :store, Store
        dependency :identifier, Identifier::UUID::Random

        def configure
          Messaging::Postgres::Write.configure(self)
          Clock::UTC.configure(self)
          Store.configure(self)
          Identifier::UUID::Random.configure(self)
        end

        category :search_fare

        # Same code will be written for every GDS gateway.
        # Potentially This gateway component SearchFareComponent
        # could be an interactor step for us, which works directly with
        # gds events.
        handle Wolfgang::FareFound do |fare_found|
          # Here we use correlation stream, we are waiting
          # for Wolfgang fare_found or Wolfgang
          # TODO: Wait for Wolfgang to return FareNotFound

          # TODO: Implement correct correlation logic.
          search_fare_id = fare_found.search_fare_id

          # This event is potentially will be ignored.
          # So it's just a marker event.
          # Still it might be usefull for debugging and coordination.

          # TODO: FoundOneOfTheFares should be usec in SearchFare projection.

          # found_one_of_the_fares = FoundOneOfTheFares.follow(fare_found)

          # write.(found_one_of_the_fares)
        end
      end
    end
  end
end
