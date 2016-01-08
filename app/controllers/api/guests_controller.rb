module Api
  class GuestsController < ApplicationController
    include Marmite::Controller
    include Concerns::JsonApiParams

    index_endpoint
    show_endpoint
    update_endpoint

    private

    def index_params
      {}
    end

    def show_params
      params.permit(:id)
    end

    def update_params
      attribute_params([:attendance, :diet, :email_address])
    end
  end
end
