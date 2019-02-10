require 'eventide/postgres'
require 'prepaid_card_provider/client'
require 'payment_terminal/client'

# TODO Load command and event message files"
# require 'fares_component/messages/commands/...'
# require 'fares_component/messages/events/...'

require 'fares_component/fares'
require 'fares_component/projection'
require 'fares_component/store'

require 'fares_component/handlers/commands'
require 'fares_component/handlers/events'

require 'fares_component/consumers/commands'
require 'fares_component/consumers/events'

require 'fares_component/start'
