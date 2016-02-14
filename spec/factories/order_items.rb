FactoryGirl.define do
  factory :order_item do
    order
    product { FactoryGirl.create(:accommodation) }

    quantity 1
    sale_price 100
  end
end
