require 'eventide/postgres'

require 'wolfgang_component/messages/commands/find_fare'
require 'wolfgang_component/messages/events/fare_found'

require 'wolfgang_component/messages/commands/book_ticket'
require 'wolfgang_component/messages/events/ticket_booked'

require 'wolfgang_component/wolfgang'
require 'wolfgang_component/projection'
require 'wolfgang_component/store'

require 'wolfgang_component/handlers/commands'
require 'wolfgang_component/handlers/events'

require 'wolfgang_component/consumers/commands'
require 'wolfgang_component/consumers/events'

require 'wolfgang_component/start'
require 'faraday'
