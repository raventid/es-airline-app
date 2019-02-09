# Entity store user guide: http://docs.eventide-project.org/user-guide/entity-store/

module PrepaidCardProviderComponent
  class Store
    include EntityStore

    category :prepaid_card_provider
    entity PrepaidCardProvider
    projection Projection
    reader MessageStore::Postgres::Read, batch_size: 1000

    # Optional snapshotting
    # snapshot EntitySnapshot::Postgres, interval: 1000
  end
end
