module Api
  class GuestsController < ApplicationController
    include Marmite::Controller

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
      params
        .require(:data)
        .require(:attributes)
        .permit(:attendance, :diet)
    end
  end
end
