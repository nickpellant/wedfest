require 'rails_helper'

RSpec.describe InviteSerializer, type: :serializer do
  subject(:invite) do
    FactoryGirl.create(:invite, :with_baskets, :with_guests, :with_orders)
  end

  let(:baskets) { invite.baskets }
  let(:current_basket) { baskets.first }
  let(:guests) { invite.guests }
  let(:orders) { invite.orders }

  let(:current_basket_relationship_data) do
    { id: current_basket.id.to_s, type: 'baskets' }
  end
  let(:guests_relationship_data) do
    guests.map { |guest| { id: guest.id.to_s, type: 'guests' } }
  end
  let(:orders_relationship_data) do
    orders.map { |order| { id: order.id.to_s, type: 'orders' } }
  end

  let(:actual_json) { ActiveModel::SerializableResource.new(invite).to_json }
  let(:expected_json) do
    {
      data: {
        id: invite.id.to_s,
        type: 'invites',
        attributes: {
          email_address: invite.email_address,
          invite_code: invite.invite_code
        },
        relationships: {
          current_basket: {
            data: current_basket_relationship_data
          },
          guests: {
            data: guests_relationship_data
          },
          orders: {
            data: orders_relationship_data
          }
        }
      }
    }.to_json
  end

  it { expect(actual_json).to eql(expected_json) }
end
