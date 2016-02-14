FactoryGirl.define do
  factory :accommodation do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }

    trait :budget_bell_tent do
      initial_availability 10
      name 'Budget Bell Tent'
      price 106.00
      sleeps 2
    end

    trait :luxury_bell_tent do
      name 'Luxury Bell Tent'
      price 160.00
      sleeps 2
    end

    trait :group_bell_tent do
      name 'Group Bell Tent'
      price 160.00
      sleeps 4
    end

    trait :tent_share do
      name 'Tent Share'
      price 33.50
      sleeps 1
    end

    trait :byo do
      name 'Bring Your Own'
      price 0.00
      sleeps 1
    end
  end
end
