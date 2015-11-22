FactoryGirl.define do
  factory :guest do
    invite

    name { Faker::Name.name }

    trait :non_vegetarian do
      diet 'non-vegetarian'
    end
    trait :vegetarian do
      diet 'vegetarian'
    end
    trait :vegan do
      diet 'vegan'
    end
    trait :nut_allergy do
      diet 'nut_allergy'
    end
    trait :gluten_free do
      diet 'gluten-free'
    end

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
