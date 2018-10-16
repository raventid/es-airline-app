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
    end

    # GET /reserving_seats request
    r.on "reserving_seats" do
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
