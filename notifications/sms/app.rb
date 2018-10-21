class ReservationEmailSent
  def call
    {
      status: "enqueued to message service"
    }
  end
end

class IssuingEmailSent
  def call
    {
      status: "enqueued to message service"
    }
  end
end

class PassengersMonitoring
  handle SeatsReserved do
    send_message_to_external_service
    publish_event(ReservationEmailSent.new.call)
  end

  handle TicketIssued do
    send_message_to_external_service
    publish_event(IssuingEmailSent.new.call)
  end
end
