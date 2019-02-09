require 'eventide/postgres'

# TODO Load command and event message files"
# require 'profit_planner_component/messages/commands/...'
# require 'profit_planner_component/messages/events/...'

require 'profit_planner_component/profit_planner'
require 'profit_planner_component/projection'
require 'profit_planner_component/store'

require 'profit_planner_component/handlers/commands'
require 'profit_planner_component/handlers/events'

require 'profit_planner_component/consumers/commands'
require 'profit_planner_component/consumers/events'

require 'profit_planner_component/start'
