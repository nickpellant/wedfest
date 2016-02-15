require 'rails_helper'

RSpec.describe 'Show Order', type: :request do
  subject(:show_order) { get api_order_url(id: order_id), params }

  let(:params) { {} }

  context 'when authorized' do
    include_context 'setup_doorkeeper_access_token'

    context 'when Order exist' do
      let!(:order) { FactoryGirl.create(:order) }
      let(:order_id) { order.id }

      let(:order_json) do
        ActiveModel::SerializableResource.new(order).to_json
      end

      before(:example) { show_order }

      it { expect(response.body).to eql(order_json) }
      it { expect(response).to have_http_status(:ok) }
    end

    context 'when Order not found' do
      let(:order_id) { 1 }

      let(:order_json) do
        {
          errors: [
            {
              title: I18n.translate('error_codes.show_not_found.message'),
              status: 'not_found'
            }
          ]
        }.to_json
      end

      before(:example) { show_order }

      it { expect(response.body).to eql(order_json) }
      it { expect(response).to have_http_status(:not_found) }
    end
  end

  it_behaves_like 'it is secured by doorkeeper' do
    let!(:order) { FactoryGirl.create(:order) }
    let(:order_id) { order.id }

    let(:request_method) { :get }
    let(:request_url) { api_order_url(id: order_id) }
  end
end
