class OrderItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :sale_price_pence

  belongs_to :order
  belongs_to :product
end
