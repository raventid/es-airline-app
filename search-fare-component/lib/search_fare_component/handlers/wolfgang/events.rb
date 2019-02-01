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
        handle ::Wolfgang::Client::Messages::Events::FareFound do |fare_found|
          correlation_stream_name = fare_found.metadata.correlation_stream_name
          search_fare_id = Messaging::StreamName.get_id(correlation_stream_name)


          search_fare, version = store.fetch(search_fare_id, include: :version)
          # Here we use correlation stream, we are waiting
          # for Wolfgang fare_found or Wolfgang
          # TODO: Wait for Wolfgang to return FareNotFound

          # TODO: Implement correct correlation logic.

          # This event is potentially will be ignored.
          # So it's just a marker event.
          # Still it might be usefull for debugging and coordination.

          # TODO: FoundOneOfTheFares should be usec in SearchFare projection.

          # found_one_of_the_fares = FoundOneOfTheFares.follow(fare_found)

          # write.(found_one_of_the_fares)
        end



        # # Move to GDS handler
        # #
        # # This code should be moved to individual GDS handler.
        # handle GDS::Client::FareFound do |fare_found|
        #   entity = fare_found.search_fare_id

        #   if entity.fare_found?
        #     # Fare found for all gds.
        #     write.(FareFound.follow(fare_found))
        #     return
        #   end

        #   # ADDITIONAL:
        #   # Might use timeout here to return:
        #   # FareNotFound.follow(fare_found) # .reason = "Timeout in SearchFare service"

        #   # Might be better to handle timeout from one of the child services here,
        #   # like `handle GDS::Client::SearchFareTimeout`

        #   # If not all of the gds returned FareFound events then
        #   # we are still collecting them.

        #   # This thing should be in projection:
        #   # entity.register_fare_for(fare_found.part, fare_found.fare)

        #   # To build projection we need event like this one:
        #   write.(PartiallyFareFound.follow(fare_found), entity_stream)
        #   # We write this event to our own event stream
        # end
      end
    end
  end
end
