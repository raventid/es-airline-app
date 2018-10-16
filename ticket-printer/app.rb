class App
  def handle(event)
    create_pdf if event == :notification_system_needs_a_pdf
  end

  def create_pdf
    "THIS_IS_SOMETHING_LIKE_PDF_BUT_I_M_NOT_SURE"
  end
end
