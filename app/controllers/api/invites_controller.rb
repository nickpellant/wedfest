module Api
  class InvitesController < ApplicationController
    include Marmite::Controller
    include Concerns::AuthorizeInvite
    include Concerns::JsonApiParams

    index_endpoint(service: IndexInvites)
    update_endpoint

    private

    def index_includes
      [:guests, { current_basket: :basket_items }]
    end

    def update_params
      attribute_params(:cabaret_info)
    end
  end
end
