require 'rails_helper'

RSpec.describe BasketItemSerializer, type: :serializer do
  subject(:basket_item) do
    FactoryGirl.build_stubbed(:basket_item)
  end
  let(:accommodation_product) { basket_item.product }

  let(:actual_json) do
    ActiveModel::SerializableResource.new(basket_item).to_json
  end
  let(:expected_json) do
    {
      data: {
        id: basket_item.id.to_s,
        type: 'basket_items',
        attributes: {
          quantity: basket_item.quantity
        },
        relationships: {
          basket: {
            data: {
              id: basket_item.basket.id.to_s,
              type: 'baskets'
            }
          },
          product: {
            data: {
              id: accommodation_product.id.to_s,
              type: 'accommodations'
            }
          }
        }
      }
    }.to_json
  end

  it { expect(actual_json).to eql(expected_json) }
end
