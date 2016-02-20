class ChargeOrder
  def initialize(order:)
    @order = order
  end

  def call
    charge = Stripe::Charge.create(
      amount: order.total_price_pence,
      source: order.stripe_token,
      currency: 'gbp'
    )

    order.order_charges.create!(stripe_charge_id: charge.id)
  end

  private

  attr_reader :order
end
