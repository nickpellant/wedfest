class Order < ActiveRecord::Base
  belongs_to :basket

  has_many :order_items
end
