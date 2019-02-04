module ViewModels
  class SearchFare
    include Mongoid::Document
    include Mongoid::Timestamps::Created
    include Mongoid::Timestamps::Updated
    store_in collection: "search_fare", database: "es_airline_app"
    field :key, type: String
    field :status, type: String # completed, in_progress
    embeds_many :fares
  end

  class Fare
    include Mongoid::Document
    field :fare_price, type: String
    field :taxe_price, type: String
    field :total_price, type: String
    field :fare_rules, type: String
    embedded_in :search_fare
  end
end
