class BasketSerializer < ActiveModel::Serializer
  attributes :id

  has_many :basket_items
end
