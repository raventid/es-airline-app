require 'eventide/postgres'

# TODO Load command and event message files"
# require 'charters_component/messages/commands/...'
# require 'charters_component/messages/events/...'

require 'charters_component/charters'
require 'charters_component/projection'
require 'charters_component/store'

require 'charters_component/handlers/commands'
require 'charters_component/handlers/events'

require 'charters_component/consumers/commands'
require 'charters_component/consumers/events'

require 'charters_component/start'