require 'rails_helper'
require 'support/shared_contexts/setup_doorkeeper_access_token'
require 'support/shared_examples/it_is_secured_by_doorkeeper'

RSpec.describe 'Create Order', type: :request do
  subject(:create_order) { post api_orders_url, params }

  let(:create_attributes) do
    FactoryGirl.attributes_for(:order).slice(*%i(slice_token))
  end
  let(:basket) { FactoryGirl.create(:basket, :with_basket_items) }

  let(:params) do
    {
      data: {
        type: 'orders',
        attributes: create_attributes,
        relationships: {
          basket: {
            data: {
              id: basket.id,
              type: 'baskets'
            }
          }
        }
      }
    }
  end

  let(:created_order) { Order.last }

  let(:order_json) do
    ActiveModel::SerializableResource.new(created_order).to_json
  end

  context 'when authorized' do
    include_context 'setup_doorkeeper_access_token'

    before(:example) { create_order }

    context 'when params pass validation' do
      it { expect(response.body).to eql(order_json) }
      it { expect(response).to have_http_status(:created) }
      it { expect(created_order).to have_attributes(create_attributes) }
      it { expect(created_order.basket).to eql(basket) }
    end

    context 'when params fail validation' do
      let(:order_json) do
        {
          errors: [
            {
              title: I18n.translate(
                'error_codes.create_validation_failed.message'
              ),
              status: 'conflict',
              details: {
                basket: ['can\'t be blank']
              }
            }
          ]
        }.to_json
      end

      let(:params) do
        {
          data: {
            type: 'orders',
            attributes: {}
          }
        }
      end

      it { expect(response.body).to eql(order_json) }
      it { expect(response).to have_http_status(:conflict) }
    end
  end

  it_behaves_like 'it is secured by doorkeeper' do
    let(:request_method) { :post }
    let(:request_url) { api_orders_url }
    let(:request_params) { params }
  end
end
