require 'eventide/postgres'

# TODO Load command and event message files"
# require 'wolfgang_component/messages/commands/...'
# require 'wolfgang_component/messages/events/...'

require 'wolfgang_component/wolfgang'
require 'wolfgang_component/projection'
require 'wolfgang_component/store'

require 'wolfgang_component/handlers/commands'
require 'wolfgang_component/handlers/events'

require 'wolfgang_component/consumers/commands'
require 'wolfgang_component/consumers/events'

require 'wolfgang_component/start'
