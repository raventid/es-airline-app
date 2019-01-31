require_relative '../init.rb'
require 'securerandom'

module WolfgangComponent; end
include WolfgangComponent

wolfgang_id = Identifier::UUID::Random.get
deposit = Messages::Commands::FindFare.new
deposit.wolfgang_id = wolfgang_id
deposit.time = '2000-01-01T11:11:11.000Z'

command_stream_name = "wolfgang:command-#{wolfgang_id}"

Messaging::Postgres::Write.(deposit, command_stream_name)

# MessageStore::Postgres::Read.(command_stream_name) do |message_data|
#   Handlers::Commands.(message_data)
# end
