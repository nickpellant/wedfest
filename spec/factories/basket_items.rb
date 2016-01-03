FactoryGirl.define do
  factory :basket_item do
    product { FactoryGirl.create(:accommodation) }
    quantity 1
  end
end
