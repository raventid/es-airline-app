# Handler user guide: http://docs.eventide-project.org/user-guide/handlers.html
# Message user guide: http://docs.eventide-project.org/user-guide/messages-and-message-data/

module SearchFareComponent
  module Handlers
    class Events
      include Messaging::Handle
      include Messaging::StreamName
      include Log::Dependency
      # include Messages::Events once events are implemented
      # include Messages::Events

      # Note: Delete this file if not handling events

      # TODO Implement event handler blocks
      # eg:
      # handle SomethingHappened do |something_happened|
      # end
      handle Initiated do |initiated|
        # We initiated the search
        #
        # 1. register_flight_parts in entity
        # 2. Issue command for every GDS gateway.
      end

      # Move to GDS handler
      #
      #
      handle GDS::Client::FareFound do |fare_found|
        entity = fare_found.search_fare_id

        if entity.fare_found?
          # Fare found for all gds.
          write.(FareFound.follow(fare_found))
          return
        end

        # ADDITIONAL:
        # Might use timeout here to return:
        # FareNotFound.follow(fare_found) # .reason = "Timeout in SearchFare service"

        # Might be better to handle timeout from one of the child services here,
        # like `handle GDS::Client::SearchFareTimeout`

        # If not all of the gds returned FareFound events then
        # we are still collecting them.

        # This thing should be in projection:
        # entity.register_fare_for(fare_found.part, fare_found.fare)

        # To build projection we need event like this one:
        write.(PartiallyFareFound.follow(fare_found), entity_stream)
        # We write this event to our own event stream
      end
    end
  end
end
