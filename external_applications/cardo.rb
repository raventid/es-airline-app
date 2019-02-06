require "webrick"
require "json"
require_relative "../global_config"

class GetCardServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    puts request
    response.content_type = "application/json"
    response.status = 200
    response.body = payload
  end

  def payload
    {
      pan: "1234 0000 2345 1234",
      cvv: "123",
      issued: "07/21",
      target_gateway: "Cardo",
      rate: ["eur->usd": 2]
    }.to_json
  end
end

class GetListOfCardsServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    puts request
    response.content_type = "application/json"
    response.status = 200
    response.body = payload
  end

  def payload
    {
      cards: [
        {
          pan: "1234 0000 2345 1234",
          cvv: "123",
          issued: "07/21",
          rate: ["eur->usd": 2]
        },
        {
          pan: "2234 0000 2345 1234",
          cvv: "123",
          issued: "07/21",
          rate: ["eur->usd": 1]
        },
        {
          pan: "4234 0000 2345 1234",
          cvv: "123",
          issued: "07/21",
          rate: ["eur->usd": 1]
        }
      ]
    }.to_json
  end
end

server = WEBrick::HTTPServer.new(Port: CARDO_SERVER_APP_PORT)

server.mount "/get_card", GetCardServlet
server.mount "/get_list_of_cards", GetListOfCardsServlet

trap "INT" do
  server.shutdown
end

server.start

