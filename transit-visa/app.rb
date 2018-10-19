# We might have a lot of services like that
# which should react to different events in processes

class TransitVisaRequired
  def call
    {
      reason: "flight from Russia to USA with transition in Germany"
    }
  end
end

class TransitVisaIsNotRequired
  def call
    {
    }
  end
end

class App
  def handle(event)
    case event
    when NewOfferCreated
      result = need_visa?

      if result
        event = TransitVisaRequired.new.call
        publish_event(need_visa)
      else
        event = TransitVisaIsNotRequired.new.call
        publish_event(need_visa)
      end
    when FlightDataHasChanged
      result = need_visa?

      if result
        event = TransitVisaRequired.new.call
        publish_event(need_visa)
      else
        event = TransitVisaIsNotRequired.new.call
        publish_event(need_visa)
      end
    end
  end

  def need_visa?
    true
  end
end
