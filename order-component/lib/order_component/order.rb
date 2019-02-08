# Entity user guide: http://docs.eventide-project.org/user-guide/entities.html
# Entity snapshotting user guide: http://docs.eventide-project.org/user-guide/entity-store/snapshotting.html

module OrderComponent
  class Order
    include Schema::DataStructure

    attribute :id, String
    attribute :pnr, String
    attribute :status, String

    # Note: This class's methods should pertain only to its attributes
  end
end
