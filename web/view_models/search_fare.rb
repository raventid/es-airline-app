module ViewModels
  class SearchFare
    include Mongoid::Document
    store_in collection: "search_fare", database: "es_airline_app", client: "secondary"

    field :key, type: String

    # Embed field with custom type.
    field :prices, type: Hash
  end
end
