require 'eventide/postgres'

# TODO Load command and event message files"
# require 'email_component/messages/commands/...'
# require 'email_component/messages/events/...'

require 'email_component/email'
require 'email_component/projection'
require 'email_component/store'

require 'email_component/handlers/commands'
require 'email_component/handlers/events'

require 'email_component/consumers/commands'
require 'email_component/consumers/events'

require 'email_component/start'
