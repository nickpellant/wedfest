module Concerns
  module CurrentBasket
    extend ActiveSupport::Concern

    included do
      def current_basket
        @current_basket ||= begin
          return unless current_guest && current_invite
          current_invite.baskets.first || Basket.create(invite: current_invite)
        end
      end
      helper_method :current_basket
    end
  end
end
