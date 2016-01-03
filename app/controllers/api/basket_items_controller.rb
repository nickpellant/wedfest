module Api
  class BasketItemsController < ApplicationController
    include Marmite::Controller

    show_endpoint

    private

    def show_params
      params.permit(:id)
    end
  end
end
