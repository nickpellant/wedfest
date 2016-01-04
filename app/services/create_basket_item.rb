class CreateBasketItem < Marmite::Services::CreateEndpoint
  before_validation :set_basket

  private

  alias basket_item resource

  def set_basket
    basket_item.basket = controller.current_basket
  end
end
