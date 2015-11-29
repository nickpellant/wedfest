class AccommodationSerializer < ActiveModel::Serializer
  attributes :id, :name, :price_pence, :sleeps
end
