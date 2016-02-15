FactoryGirl.define do
  factory :order do
    basket
    invite

    transient do
      order_item_count 1
    end

    trait(:with_stripe_token) do
      stripe_token 'tok_17drHk2eZvKYlo2CEEHm8kkG'
    end

    trait(:with_order_items) do
      after(:create) do |order, evaluator|
        order_items = create_list(
          :order_item, evaluator.order_item_count, order: order
        )
        order.order_items << order_items
      end
    end
  end
end
