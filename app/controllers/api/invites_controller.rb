module Api
  class InvitesController < ApplicationController
    include Marmite::Controller

    index_endpoint

    private

    def index_params
      params.dig(:filter)&.permit(:invite_code)
    end

    def index_includes
      [:guests, { current_basket: :basket_items }]
    end
  end
end
