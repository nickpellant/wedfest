module Api
  class BasketItemsController < ApplicationController
    include Marmite::Controller

    show_endpoint
    create_endpoint

    private

    # @TODO Implement JSON API params parser inside marmite
    def create_params
      create_params = params
                      .require(:data)
                      .require(:attributes)
                      .permit(:quantity)

      create_params[:product_id] = params.dig(:relationships, :product, :id)
      create_params[:product_type] = params.dig(:relationships, :product, :type)
        &.singularize
        &.titlecase

      create_params
    end

    def show_params
      params.permit(:id)
    end
  end
end
