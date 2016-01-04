class BasketItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity

  belongs_to :basket
  belongs_to :product
end
