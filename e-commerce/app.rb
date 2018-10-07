class Ecommerce
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
      puts "Searching fare, but I don't know what to do"
    end
  end

  class PerformReserveSeats
    def call
      puts "Reserving seats, but I don't know what to do"
    end
  end

  class PerformIssuingTicket
    def call
      puts "Issuing ticket, but I don't know what to do"
    end
  end
end
