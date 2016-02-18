require 'rails_helper'
require 'support/shared_contexts/setup_doorkeeper_access_token'
require 'support/shared_examples/it_is_secured_by_doorkeeper'

RSpec.describe 'Index Invites', type: :request do
  subject(:index_invites) { get api_invites_url, params }

  let(:params) { {} }

  context 'when authorized' do
    include_context 'setup_doorkeeper_access_token'

    before(:example) { index_invites }

    let(:invite_json) do
      ActiveModel::SerializableResource.new(
        [current_invite],
        include: [:guests, { current_basket: :basket_items }],
        scope: current_invite
      ).to_json
    end

    it { expect(response.body).to eql(invite_json) }
    it { expect(response).to have_http_status(:ok) }
  end

  it_behaves_like 'it is secured by doorkeeper' do
    let(:request_method) { :get }
    let(:request_url) { api_invites_url }
  end
end
