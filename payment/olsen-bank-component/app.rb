class PaymentCompleted
  def call
    {
      amount_paid: 1000,
      credit_left: 10000,
    }
  end
end

class PaymentFailed
  def call
    {
      reason: { "Bank rejected the card with error 1054" }
    }
  end
end

class OlsenBank
  def handle(event)
    case event
    when PayForOrder
      amount = extract_payment_amount
      result = bank.api.pay(amount)

      if result
        event = PaymentCompleted.new.call
        publish_event(event)
      else
        event = PaymentFailed.new.call
        publish_event(event)
      end
    end
  end
end
