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

      # 1. publish command to message_bus to start search_fare
      # 2. receive key to get the view later
      # 3. loop { view_storage.try_to_receive_view(key) }
      # 4. serialize view json and send to client

      # For number 4 we might use MVC web-framework and receive push notification from DB.
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
