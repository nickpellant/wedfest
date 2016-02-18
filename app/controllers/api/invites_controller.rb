module Api
  class InvitesController < ApplicationController
    include Marmite::Controller
    include Concerns::AuthorizeInvite

    index_endpoint(service: IndexInvites)

    private

    def index_includes
      [:guests, { current_basket: :basket_items }]
    end
  end
end
