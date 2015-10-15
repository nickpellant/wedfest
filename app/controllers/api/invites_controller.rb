module Api
  class InvitesController < ApplicationController
    include Marmite::Controller

    index_endpoint

    private

    # Filter params for the index endpoint
    # Requires that you provide an invite_code filter
    def index_params
      params.require(:filter).require(:invite_code)
      params[:filter].permit(:invite_code)
    end
  end
end
