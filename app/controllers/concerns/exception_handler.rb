module Concerns
  module ExceptionHandler
    include Marmite::Mixins::ExceptionRenderer
    extend ActiveSupport::Concern

    included do
      rescue_from ActionController::ParameterMissing do |exception|
        render_json_error(
          code: :parameter_missing,
          status: :bad_request,
          options: { details: exception.message }
        )
      end
    end
  end
end
