class HiddenFareFound
  def call
    {
      price: 1000
    }
  end
end

class HiddenFareNotFound
  def call
    {
      reason: "was not able to find one"
    }
  end
end

class HiddenFare
  def handle(event)
    case event
    when TicketReserved
      result = hidden_fare_api.check_for(order)
      if result
        event = HiddenFareFound.new.call
        publish_event(event)
      else
        event = HiddenFareNotFound.new.call
        publish_event(event)
      end
    end
  end
end
