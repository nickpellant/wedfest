require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to belong_to(:basket) }

  it { is_expected.to have_many(:order_items) }

  it { is_expected.to validate_presence_of(:basket) }

  describe 'guards' do
    subject(:order) { FactoryGirl.create(:order, :with_stripe_token) }

    context 'when stripe_token is set' do
      it 'can transition from state ordered to state payment_received' do
        expect do
          order.state_machine.transition_to!(:payment_received)
        end.to_not raise_error
      end
    end

    context 'when stripe_token is not set' do
      subject(:order) { FactoryGirl.create(:order) }

      it 'cannot transition from state ordered to state payment_received' do
        expect do
          order.state_machine.transition_to!(:payment_received)
        end.to raise_error(Statesman::GuardFailedError)
      end
    end
  end
end
