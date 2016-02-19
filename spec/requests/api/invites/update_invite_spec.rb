require 'rails_helper'
require 'support/shared_contexts/setup_doorkeeper_access_token'
require 'support/shared_examples/it_is_secured_by_doorkeeper'

RSpec.describe 'Update Invite', type: :request do
  subject(:update_invite) { patch api_invite_url(id: invite_id), params }

  let(:update_attributes) do
    FactoryGirl.attributes_for(:invite).slice(*%i(cabaret_info))
  end

  let(:params) do
    {
      data: {
        id: invite_id.to_s,
        type: 'invites',
        attributes: update_attributes
      }
    }
  end

  context 'when authorized' do
    include_context 'setup_doorkeeper_access_token'

    context 'when Invite exist' do
      let(:invite_id) { current_invite.id }

      let(:updated_invite) { current_invite.reload }

      let(:invite_json) do
        ActiveModel::SerializableResource.new(
          updated_invite, scope: current_invite
        ).to_json
      end

      before(:example) { update_invite }

      context 'when params pass validation' do
        it { expect(response.body).to eql(invite_json) }
        it { expect(response).to have_http_status(:ok) }
        it { expect(updated_invite).to have_attributes(update_attributes) }
      end
    end

    context 'when Invite not found' do
      let(:invite_id) { 1 }

      let(:invite_json) do
        {
          errors: [
            {
              title: I18n.translate('error_codes.update_not_found.message'),
              status: 'not_found'
            }
          ]
        }.to_json
      end

      before(:example) { update_invite }

      it { expect(response.body).to eql(invite_json) }
      it { expect(response).to have_http_status(:not_found) }
    end
  end

  it_behaves_like 'it is secured by doorkeeper' do
    let(:request_method) { :put }
    let(:request_params) { params }
    let(:invite_id) { 1 }
    let(:request_url) { api_invite_url(id: invite_id) }
  end
end
