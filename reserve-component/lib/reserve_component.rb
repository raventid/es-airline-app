require 'eventide/postgres'

# TODO Load command and event message files"
# require 'reserve_component/messages/commands/...'
# require 'reserve_component/messages/events/...'

require 'reserve_component/reserve'
require 'reserve_component/projection'
require 'reserve_component/store'

require 'reserve_component/handlers/commands'
require 'reserve_component/handlers/events'

require 'reserve_component/consumers/commands'
require 'reserve_component/consumers/events'

require 'reserve_component/start'
