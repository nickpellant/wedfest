class OrderCharge < ActiveRecord::Base
  belongs_to :order

  validates :order, :stripe_charge_id, presence: true
end
