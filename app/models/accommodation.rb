class Accommodation < ActiveRecord::Base
  validates :initial_availability, numericality: {
    greater_than_or_equal_to: 0,
    allow_nil: true
  }
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :sleeps, numericality: { allow_nil: true }

  monetize :price_pence, numericality: { greater_than_or_equal_to: 0 }
end
