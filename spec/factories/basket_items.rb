FactoryGirl.define do
  factory :basket_item do
    basket
    product { FactoryGirl.create(:accommodation) }

    quantity 1
  end
end
