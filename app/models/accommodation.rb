class Accommodation < ActiveRecord::Base
  validates :name, presence: true
  validates :sleeps, numericality: { allow_nil: true }
end
