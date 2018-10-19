class PassengerStateMonitored
end

class PassengersMonitoring
  def handle(event)
    case event
    when ReserveSeats, IssueTicket, OrderPaid

    end
  end
end
