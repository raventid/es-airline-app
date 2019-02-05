require "webrick"
require "json"
require_relative "../global_config"

class SearchFareServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    puts request
    response.content_type = "application/json"
    response.status = 200
    response.body = payload
  end

  def payload
    {
      flight: {
        segments: [
          {
            cities: "PAR-LON",
            duration: "30min"
          },
          {
            cities: "LON-PAR",
            duration: "30min"
          }
        ]
      },
      prices: {
        fare: 1000,
        taxes: 400,
        total: 1400,
      },
      branded_fare: {},
      rules: {
        text: "Ticket conditions

               Your booking reference is your only confirmation of booking.
               All fares charged per person, per one way flight and include all mandatory government taxes and charges.
               Prices are subject to availability and not guaranteed until purchase.

               - Changing LowFare, LowFare+ or Premium

               Changes to date, time, destination and name can be made up to 30 minutes before scheduled departure.
               The applicable change fee will apply to bookings changed 24 hours after initial purchase, or 12 hours after initial purchase for bookings made less than 24 hours before scheduled departure.
               The change fee will not be charged for bookings made more than 24 hours before scheduled departure and changed within 24 hours of initial purchase, or for bookings made less than 24 hours before scheduled departure and changed within 12 hours of initial purchase.
               You must always pay for any price difference between your existing flight and the one you're changing to. If you choose a cheaper fare, a refund will not be provided for the price difference.
               Changes can only be made to another flight where there is availability within the same ticket type.
               Destinations can only be changed from domestic to domestic (within the same country) or international to international.
               Certain tickets cannot be changed online – you'll need to call our Contact Centre to make changes.

               - Cancelling LowFare, LowFare+ or Premium

               Full refund within 4 hours of original purchase. After this time the booking is non-refundable.
               For flights to/from U.S. and for flights from Brazil, booked at least one week before departure, full refund within 24 hours of initial purchase. After this time the booking is non-refundable.
               A refund request for government taxes and charges can be made if the booking is unused.
           "
      }
    }.to_json
  end
end

class ReservingSeatsServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    puts request
    response.content_type = "application/json"
    response.status = 200
    response.body = payload
  end

  def payload
    { pnr: 675 }.to_json
  end
end

# This request is not idempotent!
class IssueTicketServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    puts request
    response.content_type = "application/json"
    response.status = 200
    response.body = payload
  end

  def payload
    { paid: true, prices: {}, branded_fare: {} }.to_json
  end
end

server = WEBrick::HTTPServer.new(Port: CHARTERS_SERVER_APP_PORT)

server.mount "/search_fare", SearchFareServlet
server.mount "/reserving_seats", ReservingSeatsServlet
server.mount "/issue_ticket", IssueTicketServlet

trap "INT" do
  server.shutdown
end

server.start
