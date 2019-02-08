# Entity user guide: http://docs.eventide-project.org/user-guide/entities.html
# Entity snapshotting user guide: http://docs.eventide-project.org/user-guide/entity-store/snapshotting.html

module OrderComponent
  class Order
    include Schema::DataStructure

    attribute :id, String
    attribute :pnr, String

    # This field acts as status(state) machine
    # Possible values are:
    # - created
    # - fare_found
    # - ticket_booked
    # - order_paid
    #
    # Also it's possible to have broken states:
    # - fare_fault
    # - payment_failure
    #
    # So, in some sense this field is a materialization of work by whole system.
    attribute :status, String

    # Note: This class's methods should pertain only to its attributes
  end
end
