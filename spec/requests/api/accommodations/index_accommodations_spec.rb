require 'rails_helper'

RSpec.describe 'Index Accommodations', type: :request do
  subject(:index_accommodations) { get api_accommodations_url }

  context 'when Accommodations exist' do
    let!(:accommodation) { FactoryGirl.create(:accommodation) }

    let(:accommodation_json) do
      ActiveModel::SerializableResource.new([accommodation]).to_json
    end

    before(:example) { index_accommodations }

    it { expect(response.body).to eql(accommodation_json) }
    it { expect(response).to have_http_status(:ok) }
  end

  context 'when no Accommodations exist' do
    let(:accommodation_json) do
      ActiveModel::SerializableResource.new([]).to_json
    end

    before(:example) { index_accommodations }

    it { expect(response.body).to eql(accommodation_json) }
    it { expect(response).to have_http_status(:ok) }
  end
end
