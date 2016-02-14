class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product, polymorphic: true

  validates :order, :product, :sale_price, presence: true
  validates :product_id, uniqueness: {
    scope: [:order, :product_type, :product_id],
    message: 'You already have a BasketItem for this Product in your Basket'
  }
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end
