module Concerns
  module CurrentInvite
    extend ActiveSupport::Concern

    included do
      def current_invite
        @current_invite ||= begin
          return unless doorkeeper_token
          Invite.find(doorkeeper_token.resource_owner_id)
        end
      end
      helper_method :current_invite
      alias_method :pundit_user, :current_invite
    end
  end
end
