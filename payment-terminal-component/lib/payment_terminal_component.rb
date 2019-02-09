require 'eventide/postgres'

require 'payment_terminal_component/load'

require 'payment_terminal_component/payment_terminal'
require 'payment_terminal_component/projection'
require 'payment_terminal_component/store'

require 'payment_terminal_component/handlers/commands'
require 'payment_terminal_component/handlers/events'

require 'payment_terminal_component/consumers/commands'
require 'payment_terminal_component/consumers/events'

require 'payment_terminal_component/start'
