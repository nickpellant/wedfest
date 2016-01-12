module Concerns
  module CurrentInvite
    extend ActiveSupport::Concern

    included do
      def current_invite
        @current_invite ||= begin
          current_guest&.invite
        end
      end
      helper_method :current_invite
    end
  end
end
