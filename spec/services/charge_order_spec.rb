require 'rails_helper'
require 'support/shared_contexts/setup_stripe_mock'

RSpec.describe ChargeOrder, type: :service do
  include_context 'setup_stripe_mock'

  subject(:charge_order) do
    described_class.new(order: order)
  end

  describe '#call' do
    subject(:call) { charge_order.call }

    let(:order) do
      FactoryGirl.create(:order, :with_stripe_token, :with_order_items)
    end

    before(:example) do
      expect(Stripe::Charge).to(
        receive(:create).and_return(double(id: 'charge_id'))
      )

      call
    end

    it 'creates an OrderCharge' do
      expect(order.order_charges.first).to(
        have_attributes(order: order, stripe_charge_id: 'charge_id')
      )
    end
  end
end
