require 'eventide/postgres'

# TODO Load command and event message files"
# require 'payment_terminal_component/messages/commands/...'
# require 'payment_terminal_component/messages/events/...'

require 'payment_terminal_component/payment_terminal'
require 'payment_terminal_component/projection'
require 'payment_terminal_component/store'

require 'payment_terminal_component/handlers/commands'
require 'payment_terminal_component/handlers/events'

require 'payment_terminal_component/consumers/commands'
require 'payment_terminal_component/consumers/events'

require 'payment_terminal_component/start'
