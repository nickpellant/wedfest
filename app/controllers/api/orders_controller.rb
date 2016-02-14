module Api
  class OrdersController < ApplicationController
    include Marmite::Controller
    include Concerns::AuthorizeInvite
    include Concerns::JsonApiParams

    create_endpoint(service: CreateOrder)

    private

    def create_params
      attribute_params(:stripe_token)
        .merge(relationship_params(basket: { data: :id }))
    end
  end
end
