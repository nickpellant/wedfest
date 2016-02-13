require 'rails_helper'
require 'support/shared_contexts/setup_doorkeeper_access_token'
require 'support/shared_examples/it_is_secured_by_doorkeeper'

RSpec.describe 'Show Basket', type: :request do
  subject(:show_basket) do
    get api_basket_url(id: basket_id), params
  end

  let(:params) { {} }

  context 'when authorized' do
    include_context 'setup_doorkeeper_access_token'

    context 'when Basket exists' do
      let!(:basket) { FactoryGirl.create(:basket) }
      let(:basket_id) { basket.id }

      let(:basket_json) do
        ActiveModel::SerializableResource.new(basket).to_json
      end

      before(:example) { show_basket }

      it { expect(response.body).to eql(basket_json) }
      it { expect(response).to have_http_status(:ok) }
    end

    context 'when Basket not found' do
      let(:basket_id) { 1 }

      let(:basket_json) do
        {
          errors: [
            {
              title: I18n.translate('error_codes.show_not_found.message'),
              status: 'not_found'
            }
          ]
        }.to_json
      end

      before(:example) { show_basket }

      it { expect(response.body).to eql(basket_json) }
      it { expect(response).to have_http_status(:not_found) }
    end
  end

  it_behaves_like 'it is secured by doorkeeper' do
    let!(:basket) { FactoryGirl.create(:basket) }
    let(:basket_id) { basket.id }

    let(:request_method) { :get }
    let(:request_url) { api_basket_url(id: basket_id) }
  end
end
