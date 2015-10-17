require 'rails_helper'

RSpec.describe GuestSerializer, type: :serializer do
  subject(:guest) { FactoryGirl.build_stubbed(:guest) }
  let(:invite) { guest.invite }

  let(:actual_json) { ActiveModel::SerializableResource.new(guest).to_json }
  let(:expected_json) do
    {
      data: {
        id: guest.id.to_s,
        type: 'guests',
        attributes: {
          name: guest.name
        },
        relationships: {
          invite: {
            data: {
              id: invite.id.to_s,
              type: 'invites'
            }
          }
        }
      }
    }.to_json
  end

  it { expect(actual_json).to eql(expected_json) }
end
