class BasketQuery < Marmite::Queries::ResourceQuery
  def initialize(relation: Basket.all)
    super
  end

  def current_basket(invite:)
    @current_basket ||= begin
      invite.baskets.first || Basket.create(invite: invite)
    end
  end
end
