require "roda"
require "mongoid"

class App < Roda
  # TODO: Sorry...
  # I'm gonna build client for searchFare, but later :)
  require_relative '../search-fare-component/init.rb'

  Mongoid.load!("./settings/mongoid.yml", :development)

  route do |r|
    # GET / request
    r.root do
      r.redirect "ping"
    end

    # GET /search_fare request
    r.on "search_fare" do
      puts "Issue a command responsible for starting search_fare"

      search_fare_id = ::Identifier::UUID::Random.get

      find_fare = SearchFareComponent::Messages::Commands::FindFare.new
      find_fare.search_fare_id = search_fare_id
      find_fare.time = '2000-01-01T11:11:11.000Z'
      find_fare.request = {
        "mow-led" => {
          departure: "MOW",
          arrival: "LED",
          gds: "wolfgang",
        }
      }

      command_stream_name = "searchFare:command-#{search_fare_id}"

      # TODO: import client to web-app. Do not use raw command.
      Messaging::Postgres::Write.(find_fare, command_stream_name)

      # loop do
      #   response = try_to_read_view(key)
      #   break if response
      # end


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

      response['Content-Type'] = 'application/json'
      {'status'=>'request is received... waiting for response'}.to_json
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
