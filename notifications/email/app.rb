class PassengersMonitoring
  def handle(event)
    case event
    when SearchFare
      PerformEmail.new.call
    when ReserveSeats
      PerformEmail.new.call
    when IssueTicket
      PerformEmail.new.call
    when PayForOrder
      PerformEmail.new.call
    end
  end

  class PerformEmail
    def call
      puts "Hi, user. This is your email."
    end
  end
end
