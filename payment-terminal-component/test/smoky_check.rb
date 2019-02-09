require_relative '../init.rb'
require 'securerandom'

module PaymentTerminalComponent; end
include PaymentTerminalComponent

payment_terminal_id = Identifier::UUID::Random.get
find_best_price = Messages::Commands::FindBestPrice.new
find_best_price.payment_terminal_id = payment_terminal_id
find_best_price.time = '2000-01-01T11:11:11.000Z'

command_stream_name = "paymentTerminal:command-#{payment_terminal_id}"

Messaging::Postgres::Write.(find_best_price, command_stream_name)

# MessageStore::Postgres::Read.(command_stream_name) do |message_data|
#   Handlers::Commands.(message_data)
# end
