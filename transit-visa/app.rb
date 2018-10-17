# We might have a lot of services like that
# which should react to different events in processes
class App
  def handle(event)
    case event
    when BookedTicket
      need_visa?
    end
  end

  def need_visa?
    true
  end
end
