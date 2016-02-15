class AccommodationSerializer < ActiveModel::Serializer
  attributes :id, :initial_availability, :name, :price_pence, :sleeps,
             :description
end
