class InvoiceIssued
  def call
    {
      price: 10000
    }
  end
end

class ImpossibleToIssueInvoice
  def call
    {
      reason: "Insufficient funds for gateway" # wrong place for this message
    }
  end
end

class App
  def handle(event)
    case event
    when OrderPlaced
      result = some_invoice_generation_logic
      if result
        event = InvoiceIssued.new.call
        publish_event(event)
      else
        event = ImpossibleToIssueInvoice.new.call
        publish_event(event)
      end
    end
  end
end
