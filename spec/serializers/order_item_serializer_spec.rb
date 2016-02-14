require 'rails_helper'

RSpec.describe OrderItemSerializer, type: :serializer do
  subject(:order_item) do
    FactoryGirl.build_stubbed(:order_item)
  end
  let(:accommodation_product) { order_item.product }

  let(:actual_json) do
    ActiveModel::SerializableResource.new(order_item).to_json
  end
  let(:expected_json) do
    {
      data: {
        id: order_item.id.to_s,
        type: 'order_items',
        attributes: {
          quantity: order_item.quantity,
          sale_price_pence: 10_000
        },
        relationships: {
          order: {
            data: {
              id: order_item.order.id.to_s,
              type: 'orders'
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
