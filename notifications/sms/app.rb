class PassengersMonitoring
  def handle(event)
    case event
    when SearchFare
      # do nothing...
    when ReserveSeats
      # do nothing...
    when IssueTicket
      # do nothing...
    when PayForOrder
      PerformSMS.new.call
    end
  end

  class PerformSMS
    def call
      puts "Hi, this is SMS from BuyTicket"
    end
  end
end
