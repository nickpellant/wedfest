class Basket < ActiveRecord::Base
  belongs_to :invite

  validates :invite, presence: true
end
