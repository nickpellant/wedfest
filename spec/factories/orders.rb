FactoryGirl.define do
  factory :order do
    basket

    trait(:with_stripe_token) do
      stripe_token 'tok_17drHk2eZvKYlo2CEEHm8kkG'
    end
  end
end
