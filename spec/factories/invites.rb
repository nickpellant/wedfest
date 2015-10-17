FactoryGirl.define do
  factory :invite do
    invite_code 'ABCDE'

    transient do
      guest_count 1
    end

    trait(:with_guests) do
      after(:create) do |invite, evaluator|
        guests = create_list(:guest, evaluator.guest_count, invite: invite)
        invite.guests << guests
      end
    end
  end
end
