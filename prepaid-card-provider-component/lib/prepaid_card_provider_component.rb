require 'eventide/postgres'

# TODO Load command and event message files"
# require 'prepaid_card_provider_component/messages/commands/...'
# require 'prepaid_card_provider_component/messages/events/...'

require 'prepaid_card_provider_component/prepaid_card_provider'
require 'prepaid_card_provider_component/projection'
require 'prepaid_card_provider_component/store'

require 'prepaid_card_provider_component/handlers/commands'
require 'prepaid_card_provider_component/handlers/events'

require 'prepaid_card_provider_component/consumers/commands'
require 'prepaid_card_provider_component/consumers/events'

require 'prepaid_card_provider_component/start'
