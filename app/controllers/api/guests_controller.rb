module Api
  class GuestsController < ApplicationController
    include Marmite::Controller

    index_endpoint
    show_endpoint

    private

    def index_params
      []
    end

    def show_params
      params.permit(:id)
    end
  end
end
