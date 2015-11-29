class Accommodation < ActiveRecord::Base
  validates :name, presence: true
  validates :sleeps, numericality: { allow_nil: true }

  monetize :price_pence, numericality: { greater_than_or_equal_to: 0 }
end
