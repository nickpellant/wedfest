require 'rails_helper'

RSpec.describe InvitePolicy, type: :policy do
  subject(:invite_policy) { described_class.new(current_invite, invite) }

  let(:invite) { FactoryGirl.build_stubbed(:invite) }

  describe '#serialized_attributes' do
    subject(:serialized_attributes) { invite_policy.serialized_attributes }

    context 'when the Invite is the current_invite' do
      let(:current_invite) { invite }

      it do
        expect(serialized_attributes).to(
          eql([:cabaret_info, :email_address, :invite_code, :name])
        )
      end
    end

    context 'when the Invite is not the current_invite' do
      let(:current_invite) { FactoryGirl.build_stubbed(:invite) }

      it do
        expect(serialized_attributes).to eql([])
      end
    end
  end
end
