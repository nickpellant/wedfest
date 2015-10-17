require 'rails_helper'

RSpec.describe 'Index Guests', type: :request do
  subject(:index_guests) { get api_guests_url }

  context 'when Guests exist' do
    let!(:guest) { FactoryGirl.create(:guest) }

    let(:guest_json) do
      ActiveModel::SerializableResource.new([guest]).to_json
    end

    before(:example) { index_guests }

    it { expect(response.body).to eql(guest_json) }
    it { expect(response).to have_http_status(:ok) }
  end

  context 'when no Guests exist' do
    let(:guest_json) do
      ActiveModel::SerializableResource.new([]).to_json
    end

    before(:example) { index_guests }

    it { expect(response.body).to eql(guest_json) }
    it { expect(response).to have_http_status(:ok) }
  end
end
