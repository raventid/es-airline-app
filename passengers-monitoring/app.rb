class PassengersMonitoring
  def handle(event)
    case event
    when SearchFare
      PerformSearchFare.new.call
    when ReserveSeats
      PerformReserveSeats.new.call
    when IssueTicket
      PerformIssuingTicket.new.call
    when PayForOrder
      PerformPayForOrder.new.call
    end
  end

  class PerformSearchFare
    def call
      puts "Passenger successfuly got new fare price"
    end
  end

  class PerformReserveSeats
    def call
      puts "Seat successfuly reserved for passenger"
    end
  end

  class PerformIssuingTicket
    def call
      puts "Ticket was issued for passenger"
    end
  end

  class PerformPayForOrder
    def call
      puts "Payment successfuly performed and accepted"
    end
  end
end
