FactoryGirl.define do
  factory :guest do
    invite

    name { Faker::Name.name }
  end
end
