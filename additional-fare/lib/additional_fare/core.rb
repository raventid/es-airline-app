# No events or commands here
# Just the core logic needed to performe domain core operations
class Core
  def run_recalculation
    result = make_external_request_to_calculation_app
    additional_fare_is_computed_correctly?(resutl)
  end

  def additional_fare_is_computed_correctly?(result)
    true
  end
end
