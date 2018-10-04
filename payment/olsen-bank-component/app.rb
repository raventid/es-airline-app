class OlsenBank
  def handle(event)
    case event
    when PayForOrder
      PerformPayForOrder.new.call
    end
  end

  class PerformPayForOrder
    def call
      puts "Perform pay for order"
    end
  end
end
