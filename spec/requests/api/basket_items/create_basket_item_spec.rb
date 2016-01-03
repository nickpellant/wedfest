require 'rails_helper'

RSpec.describe 'Update BasketItem', type: :request do
  subject(:create_basket_item) { post api_basket_items_url, params }

  let(:create_attributes) do
    FactoryGirl.attributes_for(:basket_item).slice(*%i(quantity))
  end
  let(:product) { FactoryGirl.create(:accommodation) }

  let(:params) do
    {
      data: {
        type: 'basket_items',
        attributes: create_attributes
      },
      relationships: {
        product: {
          id: product.id,
          type: 'accommodations'
        }
      }
    }
  end

  let(:created_basket_item) { BasketItem.last }

  let(:basket_item_json) do
    ActiveModel::SerializableResource.new(created_basket_item).to_json
  end

  before(:example) { create_basket_item }

  context 'when params pass validation' do
    it { expect(response.body).to eql(basket_item_json) }
    it { expect(response).to have_http_status(:created) }
    it { expect(created_basket_item).to have_attributes(create_attributes) }
    it { expect(created_basket_item.product).to eql(product) }
  end

  context 'when params fail validation' do
    let(:basket_item_json) do
      {
        errors: [
          {
            title: I18n.translate(
              'error_codes.create_validation_failed.message'
            ),
            status: 'conflict',
            details: {
              product: ['can\'t be blank'],
              quantity: ['is not a number']
            }
          }
        ]
      }.to_json
    end

    let(:create_attributes) do
      { quantity: 'invalid' }
    end

    let(:params) do
      {
        data: {
          type: 'basket_items',
          attributes: create_attributes
        }
      }
    end

    it { expect(response.body).to eql(basket_item_json) }
    it { expect(response).to have_http_status(:conflict) }
  end
end