require 'stripe_mock'

RSpec.shared_context 'setup_stripe_mock' do
  before(:example) do
    allow(Stripe::Charge).to(
      receive(:create).and_return(double(id: 'charge_id'))
    )
  end
end
