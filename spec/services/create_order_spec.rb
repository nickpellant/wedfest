require 'rails_helper'

RSpec.describe CreateOrder, type: :service do
  subject(:create_order) do
    described_class.new(attributes: attributes, controller: controller)
  end

  let!(:basket) { FactoryGirl.create(:basket, :with_basket_items) }

  let(:attributes) { { basket_id: basket.id } }
  let(:controller) { spy('Api::OrdersController') }

  before(:example) do
    allow(controller).to(
      receive_message_chain(:class, :name).and_return('Api::OrdersController')
    )
  end

  describe '#call' do
    subject(:call) { create_order.call }

    let(:created_order) { Order.find_by(attributes) }

    before(:example) { call }

    it 'creates OrderItems for each BasketItem' do
      basket.basket_items.each do |basket_item|
        product = basket_item.product

        order_item = created_order
                     .order_items
                     .find_by(
                       product: product,
                       sale_price_pence: product.price_pence,
                       quantity: basket_item.quantity
                     )

        expect(order_item).to be_present
      end
    end

    it 'transitions the Basket to purchased' do
      expect(basket.state_machine.current_state).to eql('purchased')
    end
  end
end
