module Api
  class AccommodationsController < ApplicationController
    include Marmite::Controller

    index_endpoint

    private

    def index_params
      {}
    end
  end
end
