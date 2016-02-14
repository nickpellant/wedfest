module Concerns
  module JsonApiParams
    extend ActiveSupport::Concern

    included do
      private

      def attribute_params(filters)
        permitted_params = params.dig(:data, :attributes)&.permit(filters)
        return {} unless permitted_params
        permitted_params
      end

      def relationship_params(filters)
        permitted_params = params.dig(:data, :relationships)&.permit(filters)
        return {} unless permitted_params

        permitted_params.map do |name, relationship|
          params = { "#{name}_id": relationship[:data][:id] }
          if relationship[:data][:type]
            params["#{name}_type"] =
              relationship[:data][:type]&.singularize&.titlecase
          end
          params
        end.reduce(&:merge)
      end
    end
  end
end
