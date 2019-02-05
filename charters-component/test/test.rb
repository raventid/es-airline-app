require_relative '../init.rb'
require 'securerandom'

module ChartersComponent; end
include ChartersComponent

charters_id = Identifier::UUID::Random.get
deposit = Messages::Commands::FindFare.new
deposit.charters_id = charters_id
deposit.time = '2000-01-01T11:11:11.000Z'

command_stream_name = "charters:command-#{charters_id}"

Messaging::Postgres::Write.(deposit, command_stream_name)

# MessageStore::Postgres::Read.(command_stream_name) do |message_data|
#   Handlers::Commands.(message_data)
# end
