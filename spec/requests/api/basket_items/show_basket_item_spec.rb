require 'rails_helper'
require 'support/shared_contexts/setup_doorkeeper_access_token'
require 'support/shared_examples/it_is_secured_by_doorkeeper'

RSpec.describe 'Show BasketItem', type: :request do
  subject(:show_basket_item) do
    get api_basket_item_url(id: basket_item_id), params
  end

  let(:params) { {} }

  context 'when authorized' do
    include_context 'setup_doorkeeper_access_token'

    context 'when BasketItem exist' do
      let!(:basket_item) { FactoryGirl.create(:basket_item) }
      let(:basket_item_id) { basket_item.id }

      let(:basket_item_json) do
        ActiveModel::SerializableResource.new(basket_item).to_json
      end

      before(:example) { show_basket_item }

      it { expect(response.body).to eql(basket_item_json) }
      it { expect(response).to have_http_status(:ok) }
    end

    context 'when BasketItem not found' do
      let(:basket_item_id) { 1 }

      let(:basket_item_json) do
        {
          errors: [
            {
              title: I18n.translate('error_codes.show_not_found.message'),
              status: 'not_found'
            }
          ]
        }.to_json
      end

      before(:example) { show_basket_item }

      it { expect(response.body).to eql(basket_item_json) }
      it { expect(response).to have_http_status(:not_found) }
    end
  end

  it_behaves_like 'it is secured by doorkeeper' do
    let!(:basket_item) { FactoryGirl.create(:basket_item) }
    let(:basket_item_id) { basket_item.id }

    let(:request_method) { :get }
    let(:request_url) { api_basket_item_url(id: basket_item_id) }
  end
end
