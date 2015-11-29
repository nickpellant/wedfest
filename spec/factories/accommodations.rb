FactoryGirl.define do
  factory :accommodation do
    initial_availability 10
    name { Faker::Commerce.product_name }
    price_pence 100
    sleeps 2
  end
end
