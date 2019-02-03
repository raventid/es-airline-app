require "roda"

class App < Roda
  route do |r|
    # GET / request
    r.root do
      r.redirect "ping"
    end

    # GET /search_fare request
    r.on "search_fare" do
      puts "issue a command responsible for starting search_fare"

      # 0. Intro: Build client for searchFare service.
      # Not sure if it will be the main coordinating service?
      #
      # SearchFare provides command to strat service machine.
      # key = searchFare.(params, params, search_fare_id)
      # loop with this key?

      # 1. publish command to message_bus to start search_fare

      # require "search_fare/commands/search_fare"
      # require "message_store/write_command"

      # search_fare_command = SearchFare.new(ticket_data: 100, flight: 200)
      # write_command.call(search_fare_command)

      # 2. receive key to get the view later
      # ???

      # 3. loop { view_storage.try_to_receive_view(key) }

      # 4. serialize view json and send to client
      # render response.json # easy

      # For number 4 we might use MVC web-framework or receive push notification from DB.
    end

    # GET /reserving_seats request
    r.on "reserve_seats" do
      puts "issue a command responsible for reserving_seats"
    end

    # GET /issue_ticket request
    r.on "issue_ticket" do
      puts "issue a command responsible for issue_ticket"
    end

    # GET /ping request
    r.on "ping" do
      "pong"
    end
  end
end
