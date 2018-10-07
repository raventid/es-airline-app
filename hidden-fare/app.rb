class HiddenFare
  def handle(event)
    case event
    when SearchFare
      PerformSearchFare.new.call
    when ReserveSeats
      PerformReserveSeats.new.call
    when IssueTicket
      PerformIssuingTicket.new.call
    end
  end

  class PerformSearchFare
    def call
      puts "Searching fare"
    end
  end

  class PerformReserveSeats
    def call
      puts "Reserving seats"
    end
  end

  class PerformIssuingTicket
    def call
      puts "Issuing ticket"
    end
  end
end
