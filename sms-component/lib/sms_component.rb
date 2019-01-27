require 'eventide/postgres'

# TODO Load command and event message files"
# require 'sms_component/messages/commands/...'
# require 'sms_component/messages/events/...'

require 'sms_component/sms'
require 'sms_component/projection'
require 'sms_component/store'

require 'sms_component/handlers/commands'
require 'sms_component/handlers/events'

require 'sms_component/consumers/commands'
require 'sms_component/consumers/events'

require 'sms_component/start'
