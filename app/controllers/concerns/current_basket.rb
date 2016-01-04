module Concerns
  module CurrentBasket
    extend ActiveSupport::Concern

    included do
      def current_basket
        @current_basket ||= begin
          return unless current_guest && current_invite
          BasketQuery.new(current_invite.baskets).active || current_invite.create_basket
        end
      end
      helper_method :current_basket
    end
  end
end
