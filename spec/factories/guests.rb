FactoryGirl.define do
  factory :guest do
    invite

    name { Faker::Name.name }

    trait :weekend_attendance do
      attendance 'weekend'
    end

    trait :wedding_attendance do
      attendance 'wedding'
    end

    trait :evening_attendance do
      attendance 'evening'
    end
  end
end
