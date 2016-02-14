require 'rails_helper'

RSpec.describe OrderSerializer, type: :serializer do
  subject(:order) do
    FactoryGirl.create(:order, :with_stripe_token, :with_order_items)
  end

  let(:order_items_relationship_data) do
    order.order_items.map do |order_item|
      { id: order_item.id.to_s, type: 'order_items' }
    end
  end

  let(:actual_json) { ActiveModel::SerializableResource.new(order).to_json }
  let(:expected_json) do
    {
      data: {
        id: order.id.to_s,
        type: 'orders',
        relationships: {
          invite: {
            data: {
              id: order.invite.id.to_s,
              type: 'invites'
            }
          },
          order_items: {
            data: order_items_relationship_data
          }
        }
      }
    }.to_json
  end

  it { expect(actual_json).to eql(expected_json) }
end
