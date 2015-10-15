require 'rails_helper'

RSpec.describe 'Index Invites', type: :request do
  subject(:index_invites) { get api_invites_url, params }

  before(:example) { index_invites }

  context 'when params include an invite_code filter' do
    let(:params) { { filter: { invite_code: invite_code } } }

    context 'when an Invite exists matching the invite_code' do
      let(:invite) { FactoryGirl.create(:invite) }
      let(:invite_code) { invite.invite_code }

      let(:invite_json) do
        ActiveModel::SerializableResource.new([invite]).to_json
      end

      it { expect(response.body).to eql(invite_json) }
      it { expect(response).to have_http_status(:ok) }
    end

    context 'when no Invite exists matching the invite_code' do
      let(:invite_code) { 'INVALID' }

      let(:invite_json) do
        ActiveModel::SerializableResource.new([]).to_json
      end

      it { expect(response.body).to eql(invite_json) }
      it { expect(response).to have_http_status(:ok) }
    end
  end

  context 'when params do not include an invite_code filter' do
    let(:params) { {} }

    it { expect(response).to have_http_status(:bad_request) }
  end
end
