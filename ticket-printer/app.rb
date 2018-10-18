class TicketConfirmed
  def call
    {
      timestamp: "214242121",
      ticket_number: 1000,
      ticket_owner: "raventid"
    }
  end
end

class TicketNotConfirmed
  def call
    {
      timmestamp: "24324343",
      ticket_number: nil,
      ticket_owner: "raventid"
    }
  end
end


class App
  def handle(event)
    case event
    when PaymentReceived
      result = IssueTicket.new.call
      if result == :success
        publish_event(TicketConfirmed.new.call)
      else
        publish_event(TicketNotConfirmed.new.call)
      end
    end
  end
end

class IssueTicket
  def call
    # run buisness logic to issue ticket
    # very complicated buissness logic
    :success
  end
end
