class PdfTicketIssued
  def call(link_to_pdf)
    {
      timestamp: "242142142",
      link_to_pdf: link_to_pdf,
      some_additional_info: "some additional info"
    }
  end
end


class Charter
  def handle(event)
    case event
    when SearchFare
      PerformSearchFare.new.call
    when ReserveSeats
      PerformReserveSeats.new.call
    when IssueTicket
      PerformIssuingTicket.new.call
    when TicketConfirmed
      raw_pdf = GeneratePdfTicket.new.call
      link_to_pdf = save_pdf_to_s3(raw_pdf)
      event = PdfTicketIssued.new.call(link_to_pdf)
      publish_event(event)
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

  class GeneratePdfTicket
    def call
      puts "PDF should be here"
    end
  end
end
