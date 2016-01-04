require 'rails_helper'
require 'support/shared_contexts/setup_doorkeeper_access_token'
require 'support/shared_examples/it_is_secured_by_doorkeeper'

RSpec.describe 'Update BasketItem', type: :request do
  subject(:update_basket_item) do
    patch api_basket_item_url(id: basket_item_id), params
  end

  let(:update_attributes) do
    FactoryGirl.attributes_for(:basket_item).slice(*%i(quantity))
  end

  let(:params) do
    {
      data: {
        id: basket_item_id.to_s,
        type: 'basket_items',
        attributes: update_attributes
      }
    }
  end

  context 'when authorized' do
    include_context 'setup_doorkeeper_access_token'

    context 'when BasketItem exist' do
      let!(:basket_item) { FactoryGirl.create(:basket_item) }
      let(:basket_item_id) { basket_item.id }

      let(:updated_basket_item) { basket_item.reload }

      let(:basket_item_json) do
        ActiveModel::SerializableResource.new(updated_basket_item).to_json
      end

      before(:example) { update_basket_item }

      context 'when params pass validation' do
        it { expect(response.body).to eql(basket_item_json) }
        it { expect(response).to have_http_status(:ok) }
        it { expect(updated_basket_item).to have_attributes(update_attributes) }
      end

      context 'when params fail validation' do
        let(:basket_item_json) do
          {
            errors: [
              {
                title: I18n.translate(
                  'error_codes.update_validation_failed.message'
                ),
                status: 'conflict',
                details: {
                  quantity: ['is not a number']
                }
              }
            ]
          }.to_json
        end

        let(:update_attributes) do
          { quantity: 'invalid' }
        end

        it { expect(response.body).to eql(basket_item_json) }
        it { expect(response).to have_http_status(:conflict) }
        it do
          expect(updated_basket_item).to_not have_attributes(update_attributes)
        end
      end
    end

    context 'when BasketItem not found' do
      let(:basket_item_id) { 1 }

      let(:basket_item_json) do
        {
          errors: [
            {
              title: I18n.translate('error_codes.update_not_found.message'),
              status: 'not_found'
            }
          ]
        }.to_json
      end

      before(:example) { update_basket_item }

      it { expect(response.body).to eql(basket_item_json) }
      it { expect(response).to have_http_status(:not_found) }
    end
  end

  it_behaves_like 'it is secured by doorkeeper' do
    let!(:basket_item) { FactoryGirl.create(:basket_item) }
    let(:basket_item_id) { basket_item.id }

    let(:request_method) { :patch }
    let(:request_url) { api_basket_item_url(id: basket_item_id) }
    let(:request_params) { params }
  end
end
