require 'rails_helper'
require 'support/shared_contexts/setup_stripe_mock'

RSpec.describe CreateOrder, type: :service do
  include_context 'setup_stripe_mock'

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

    it 'sets the Invite on the Order to that of the Basket' do
      expect(created_order.invite).to eql(basket.invite)
    end

    it 'sets the total_price for the Order' do
      expect(created_order.total_price_pence).to eql(0)
    end

    it 'creates OrderItems for each BasketItem' do
      basket.basket_items.each do |basket_item|
        product = basket_item.product
        total_price_pence = basket_item.quantity * product.price * 100

        order_item = created_order
                     .order_items
                     .find_by(
                       product: product,
                       sale_price_pence: product.price_pence,
                       quantity: basket_item.quantity,
                       total_price_pence: total_price_pence
                     )

        expect(order_item).to be_present
      end
    end

    it 'transitions the Basket to purchased' do
      expect(basket.state_machine.current_state).to eql('purchased')
    end

    context 'when the attributes include a stripe_token' do
      let(:attributes) { { basket_id: basket.id, stripe_token: 'token' } }

      it 'transitions the Order to payment_received' do
        expect(created_order.state_machine.current_state).to(
          eql('payment_received')
        )
      end
    end
  end
end
