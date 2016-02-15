class OrderSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :invite

  has_many :order_items
end
