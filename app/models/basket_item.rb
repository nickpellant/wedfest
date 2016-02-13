class BasketItem < ActiveRecord::Base
  belongs_to :basket
  belongs_to :product, polymorphic: true

  validates :basket, :product, presence: true
  validates :product_id, uniqueness: {
    scope: [:basket, :product_type, :product_id],
    message: 'You already have a BasketItem for this Product in your Basket'
  }
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end
