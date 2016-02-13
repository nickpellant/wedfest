FactoryGirl.define do
  factory :basket do
    invite

    transient do
      basket_item_count 1
    end

    trait(:with_basket_items) do
      after(:create) do |basket, evaluator|
        basket_items = create_list(
          :basket_item, evaluator.basket_item_count, basket: basket
        )
        basket.basket_items << basket_items
      end
    end
  end
end
