class BasketItem < ActiveRecord::Base
  belongs_to :product, polymorphic: true

  validates :product, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end
