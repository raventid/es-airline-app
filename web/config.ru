require "roda"

class App < Roda
  route do |r|
    # GET / request
    r.root do
      r.redirect "ping"
    end

    # GET /search_fare request
    r.on "search_fare" do
      puts "run component responsible for search_fare"
    end

    # GET /reserving_seats request
    r.on "reserving_seats" do
      puts "run component responsible for reserving_seats"
    end

    # GET /issue_ticket request
    r.on "issue_ticket" do
      puts "run component responsible for issue_ticket"
    end

    # GET /ping request
    r.on "ping" do
      "pong"
    end
  end
end

run App.freeze.app
