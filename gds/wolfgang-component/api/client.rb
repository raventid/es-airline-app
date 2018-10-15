require_relative "../../../global_config.rb"

module Api
  class Client
    def search_fare
      {
        flight: {},
        passengers: {},
        additional_info: {},
      }
    end

    def reserve_seats
      {
        flight: {},
        passengers: {},
        additional_info: {},
      }
    end

    def issue_ticket
      {
        flight: {},
        passengers: {},
        additional_info: {},
      }
    end

    private

    def port
      WOLFGANG_EXTERNAL_APP_PORT
    end
  end
end
