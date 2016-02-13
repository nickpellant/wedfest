require 'rails_helper'

RSpec.describe InviteSerializer, type: :serializer do
  subject(:invite) { FactoryGirl.create(:invite, :with_baskets, :with_guests) }

  let(:baskets) { invite.baskets }
  let(:current_basket) { baskets.first }
  let(:guests) { invite.guests }

  let(:current_basket_relationship_data) do
    { id: current_basket.id.to_s, type: 'baskets' }
  end
  let(:guests_relationship_data) do
    guests.map { |guest| { id: guest.id.to_s, type: 'guests' } }
  end

  let(:actual_json) { ActiveModel::SerializableResource.new(invite).to_json }
  let(:expected_json) do
    {
      data: {
        id: invite.id.to_s,
        type: 'invites',
        attributes: {
          invite_code: invite.invite_code
        },
        relationships: {
          current_basket: {
            data: current_basket_relationship_data
          },
          guests: {
            data: guests_relationship_data
          }
        }
      }
    }.to_json
  end

  it { expect(actual_json).to eql(expected_json) }
end
