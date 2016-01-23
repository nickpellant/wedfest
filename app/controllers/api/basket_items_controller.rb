module Api
  class BasketItemsController < ApplicationController
    include Marmite::Controller
    include Concerns::AuthorizeInvite
    include Concerns::JsonApiParams

    create_endpoint(service: CreateBasketItem)
    show_endpoint
    update_endpoint

    private

    def create_params
      attribute_params(:quantity)
        .merge(relationship_params(product: { data: [:id, :type] }))
    end

    def update_params
      attribute_params(:quantity)
    end

    def show_params
      params.permit(:id)
    end
  end
end
