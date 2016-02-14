require 'rails_helper'

RSpec.describe BasketSerializer, type: :serializer do
  subject(:basket) { FactoryGirl.create(:basket, :with_basket_items) }

  let(:basket_items_relationship_data) do
    basket.basket_items.map do |basket_item|
      { id: basket_item.id.to_s, type: 'basket_items' }
    end
  end

  let(:actual_json) { ActiveModel::SerializableResource.new(basket).to_json }
  let(:expected_json) do
    {
      data: {
        id: basket.id.to_s,
        type: 'baskets',
        relationships: {
          invite: {
            data: {
              id: basket.invite.id.to_s,
              type: 'invites'
            }
          },
          basket_items: {
            data: basket_items_relationship_data
          }
        }
      }
    }.to_json
  end

  it { expect(actual_json).to eql(expected_json) }
end
