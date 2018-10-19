class PromocodeApplied
  def call
    {
      issued: "datetime"
    }
  end
end

class App
  def handle(event)
    case event
    when PromoCodeReceived
      event = PromocodeApplied.new.call
      publish_event(event)
    end
  end
end
