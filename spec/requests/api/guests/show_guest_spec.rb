require 'rails_helper'

RSpec.describe 'Show Guest', type: :request do
  subject(:show_guest) { get api_guest_url(id: guest_id) }

  context 'when Guest exist' do
    let!(:guest) { FactoryGirl.create(:guest) }
    let(:guest_id) { guest.id }

    let(:guest_json) do
      ActiveModel::SerializableResource.new(guest).to_json
    end

    before(:example) { show_guest }

    it { expect(response.body).to eql(guest_json) }
    it { expect(response).to have_http_status(:ok) }
  end

  context 'when Guest not found' do
    let(:guest_id) { 1 }

    let(:guest_json) { {}.to_json }

    before(:example) { show_guest }

    it { expect(response.body).to eql(guest_json) }
    it { expect(response).to have_http_status(:not_found) }
  end
end
