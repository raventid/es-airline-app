# Entity store user guide: http://docs.eventide-project.org/user-guide/entity-store/

module OrderComponent
  class Store
    include EntityStore

    category :order
    entity Order
    projection Projection
    reader MessageStore::Postgres::Read, batch_size: 1000

    # Optional snapshotting
    # snapshot EntitySnapshot::Postgres, interval: 1000
  end
end
