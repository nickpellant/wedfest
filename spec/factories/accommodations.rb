FactoryGirl.define do
  factory :accommodation do
    name { Faker::Commerce.product_name }
    price_pence 100
    sleeps 2
  end
end
