require 'rails_helper'

RSpec.describe InviteSerializer, type: :serializer do
  subject(:invite) { FactoryGirl.build_stubbed(:invite) }

  let(:actual_json) { ActiveModel::SerializableResource.new(invite).to_json }
  let(:expected_json) do
    {
      data: {
        id: invite.id.to_s,
        type: 'invites',
        attributes: {
          invite_code: invite.invite_code
        }
      }
    }.to_json
  end

  it { expect(expected_json).to eql(actual_json) }
end
