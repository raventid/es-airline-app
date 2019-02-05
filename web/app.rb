require "roda"
require "mongoid"
require_relative "./view_models/search_fare.rb"

class App < Roda
  # TODO: Sorry...
  # I'm gonna build client for searchFare, but later :)
  require_relative '../search-fare-component/init.rb'

  Mongoid.load!("./settings/mongoid.yml", :development)
  # Mongoid.connect_to("es_airline_app")

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
        },
        "led-mow" => {
          departure: "LED",
          arrival: "MOW",
          gds: "charters"
        }
      }

      command_stream_name = "searchFare:command-#{search_fare_id}"

      # TODO: import client to web-app. Do not use raw command.
      Messaging::Postgres::Write.(find_fare, command_stream_name)

      # I know, I know... sorry
      view = nil
      while !view || view&.status != "completed" do
         sleep 0.1
         view = ViewModels::SearchFare.where(key: search_fare_id.to_s).first
       end

      response['Content-Type'] = 'application/json'

      # Just render view from Mongodb.
      view.to_json
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
