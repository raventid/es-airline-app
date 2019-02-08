require_relative '../init.rb'

module SearchFareComponent; end
include SearchFareComponent

search_fare_id = Identifier::UUID::Random.get

find_fare = Messages::Commands::FindFare.new
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

Messaging::Postgres::Write.(find_fare, command_stream_name)
