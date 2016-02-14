class CreateOrder < Marmite::Services::CreateEndpoint
  after_create :transition_basket
  after_create :create_order_items

  private

  alias order resource
  delegate :basket, to: :order

  def create_order_items
    basket.basket_items.each do |basket_item|
      product = basket_item.product
      order.order_items.create(product: product, sale_price: product.price)
    end
  end

  def transition_basket
    basket.state_machine.transition_to!(:purchased)
  end

  def transition_order
    if order.stripe_token
      order.state_machine.transition_to!(:payment_received)
    end
  end
end
