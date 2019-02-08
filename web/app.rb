require "roda"
require "mongoid"
require_relative "./view_models/search_fare.rb"

class App < Roda
  # TODO: Sorry...
  # I'm gonna build client for searchFare, but later :)
  require_relative '../search-fare-component/init.rb'
  require_relative '../book-ticket-component/init.rb'

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


      # TODO: import client to web-app. Do not use raw command.
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

    # GET /book_ticket request
    r.on "book_ticket" do
      puts "Issue a command responsible for starting book_ticket"
      # if order not exists? what to do?

      # TODO: import client to web-app. Do not use raw command.
      book_ticket_id = ::Identifier::UUID::Random.get

      book_ticket = BookTicketComponent::Messages::Commands::BookTicketM.new
      book_ticket.book_ticket_id = book_ticket_id
      book_ticket.time = '2000-01-01T11:11:11.000Z'
      book_ticket.request = {
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

      command_stream_name = "bookTicket:command-#{book_ticket_id}"

      Messaging::Postgres::Write.(book_ticket, command_stream_name)

      # # I know, I know... sorry
      # view = nil
      # while !view || view&.status != "completed" do
      #    sleep 0.1
      #    view = ViewModels::SearchFare.where(key: search_fare_id.to_s).first
      #  end

      # response['Content-Type'] = 'application/json'

      # # Just render view from Mongodb.
      # view.to_json
      response['Content-Type'] = 'application/json'
      response = {obrabotal: true}.to_json
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
