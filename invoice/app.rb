class App
  def handle(event)
    OrderCompleted.new.start if event == :order_completed
  end
end
