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
    { flight: {}, prices: {}, branded_fare: {} }.to_json
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
    { flight: {}, prices: {}, branded_fare: {} }.to_json
  end
end

class IssueTicketServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    puts request
    response.content_type = "application/json"
    response.status = 200
    response.body = payload
  end

  def payload
    { flight: {}, prices: {}, branded_fare: {} }.to_json
  end
end

server = WEBrick::HTTPServer.new(Port: WOLFGANG_EXTERNAL_APP_PORT)

server.mount "/search_fare", SearchFareServlet
server.mount "/reserving_seats", ReservingSeatsServlet
server.mount "/issue_ticket", IssueTicketServlet

trap "INT" do
  server.shutdown
end

server.start
