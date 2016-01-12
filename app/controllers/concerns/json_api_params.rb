module Concerns
  module JsonApiParams
    extend ActiveSupport::Concern

    included do
      private

      def attribute_params(filters)
        params.require(:data).require(:attributes).permit(filters)
      end

      def relationship_params(filters)
        permitted_params = params.dig(:relationships)&.permit(filters)
        return {} unless permitted_params

        relationship_params = permitted_params.map do |name, relationship|
          {
            "#{name}_id": relationship[:data][:id],
            "#{name}_type": relationship[:data][:type]&.singularize&.titlecase
          }
        end

        relationship_params.reduce(&:merge)
      end
    end
  end
end
