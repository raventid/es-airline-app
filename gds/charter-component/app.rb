class PdfTicketIssued
  def call(link_to_pdf)
    {
      timestamp: "242142142",
      link_to_pdf: link_to_pdf,
      some_additional_info: "some additional info"
    }
  end
end

class FareFound
  def call(link_to_pdf)
    {
      timestamp: "242142142",
      price: {
        adult: 1000,
        child: 1000,
        infant: 0
      }
    }
  end
end

class FareNotFound
  def call(link_to_pdf)
    {
      timestamp: "242142142",
      price: {
        adult: 1000,
        child: 1000,
        infant: 0
      }
    }
  end
end


class Charter
  def handle(event)
    case event
    when SearchFare
      # Internally we get a huge XML we should save
      # We should also save parsed result

      # malformed xml received (XML is huge)
      # error in parser code
      result = api.search_fare

      event = if result
                FareFound.new.call
              else
                FareNotFound.new.call
              end

      publish_event(event)
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
