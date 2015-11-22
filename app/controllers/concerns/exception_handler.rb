module Concerns
  module ExceptionHandler
    extend ActiveSupport::Concern

    included do
      rescue_from ActionController::ParameterMissing do |exception|
        render_json_error(
          code: :parameter_missing,
          status: :bad_request,
          options: { details: exception.message }
        )
      end

      # Renders a JSON error response
      # @param code [Symbol] the error code
      # @param status [Symbol] the HTTP status to respond with
      # @param details [Hash] additional error details
      def render_json_error(code:, status:, options: {})
        error = {
          code: I18n.t("error_codes.#{code}.code"),
          title: I18n.t("error_codes.#{code}.message"),
          status: status
        }.merge(options)

        render json: { errors: [error] }, status: status
      end
    end
  end
end
