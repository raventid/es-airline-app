require 'eventide/postgres'

require 'search_fare_component/messages/commands/find_fare'
require 'search_fare_component/messages/events/fare_found'

require 'search_fare_component/search_fare'
require 'search_fare_component/projection'
require 'search_fare_component/store'

require 'search_fare_component/handlers/commands'
require 'search_fare_component/handlers/events'

require 'search_fare_component/consumers/commands'
require 'search_fare_component/consumers/events'

require 'search_fare_component/start'
