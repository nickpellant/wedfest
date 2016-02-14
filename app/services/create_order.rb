class CreateOrder < Marmite::Services::CreateEndpoint
  after_create :create_order_items
  after_create :transition_basket

  private

  alias order resource
  delegate :basket, to: :order

  def create_order_items
    basket.basket_items.each do |basket_item|
      product = basket_item.product
      order.order_items.create!(
        product: product,
        sale_price: product.price,
        quantity: basket_item.quantity
      )
    end
  end

  def transition_basket
    basket.state_machine.transition_to!(:purchased)
  end
end
