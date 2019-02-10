require_relative '../init.rb'
require 'securerandom'

module PrepaidCardProviderComponent; end
include PrepaidCardProviderComponent

prepaid_card_provider_id = Identifier::UUID::Random.get
calculate_prepaid_card_profit = Messages::Commands::CalculatePrepaidCardProfit.new
calculate_prepaid_card_profit.prepaid_card_provider_id = prepaid_card_provider_id
calculate_prepaid_card_profit.time = '2000-01-01T11:11:11.000Z'

command_stream_name = "prepaidCardProvider:command-#{prepaid_card_provider_id}"

Messaging::Postgres::Write.(calculate_prepaid_card_profit, command_stream_name)

# MessageStore::Postgres::Read.(command_stream_name) do |message_data|
#   Handlers::Commands.(message_data)
# end
