FactoryGirl.define do
  factory :order do
    basket

    stripe_token 'tok_17drHk2eZvKYlo2CEEHm8kkG'
  end
end
