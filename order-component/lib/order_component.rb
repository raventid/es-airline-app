require 'eventide/postgres'

# TODO Load command and event message files"
# require 'order_component/messages/commands/...'
# require 'order_component/messages/events/...'

require 'order_component/order'
require 'order_component/projection'
require 'order_component/store'

require 'order_component/handlers/commands'
require 'order_component/handlers/events'

require 'order_component/consumers/commands'
require 'order_component/consumers/events'

require 'order_component/start'
