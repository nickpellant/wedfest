class BasketSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :invite

  has_many :basket_items
end
