require 'eventide/postgres'

require 'prepaid_card_provider_component/load'

require 'prepaid_card_provider_component/prepaid_card_provider'
require 'prepaid_card_provider_component/projection'
require 'prepaid_card_provider_component/store'

require 'prepaid_card_provider_component/handlers/commands'
require 'prepaid_card_provider_component/handlers/events'

require 'prepaid_card_provider_component/consumers/commands'
require 'prepaid_card_provider_component/consumers/events'

require 'prepaid_card_provider_component/start'
