module Api
  class BasketsController < ApplicationController
    include Marmite::Controller
    include Concerns::AuthorizeInvite
    include Concerns::JsonApiParams

    show_endpoint

    private

    def show_includes
      :basket_items
    end

    def show_params
      params.permit(:id)
    end
  end
end
