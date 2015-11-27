FactoryGirl.define do
  factory :accommodation do
    name { Faker::Commerce.product_name }
    sleeps 2
  end
end
