class CreateOrder < Marmite::Services::CreateEndpoint
  before_validation :set_invite

  after_create :create_order_items
  after_create :set_order_total_price
  after_create :transition_basket
  after_create :transition_order

  private

  alias order resource
  delegate :basket, to: :order

  def create_order_items
    basket.basket_items.each do |basket_item|
      product = basket_item.product
      order.order_items.create!(
        product: product,
        sale_price: product.price,
        quantity: basket_item.quantity,
        total_price: basket_item.quantity * product.price
      )
    end
  end

  def set_order_total_price
    order.update(total_price: order.order_items.map(&:total_price).reduce(:+))
  end

  def set_invite
    return unless order.basket.present?
    order.invite = order.basket.invite
  end

  def transition_basket
    basket.state_machine.transition_to!(:purchased)
  end

  def transition_order
    return unless order.stripe_token.present?
    order.state_machine.transition_to!(:payment_received)
  end
end
