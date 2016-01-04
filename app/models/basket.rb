class Basket < ActiveRecord::Base
  belongs_to :invite
  has_many :basket_items

  validates :invite, presence: true
end
