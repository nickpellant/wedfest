module Concerns
  module CurrentGuest
    extend ActiveSupport::Concern

    included do
      def current_guest
        @current_guest ||= begin
          return unless doorkeeper_token
          Guest.find(doorkeeper_token.resource_owner_id)
        end
      end
      helper_method :current_guest
    end
  end
end
