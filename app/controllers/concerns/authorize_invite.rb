module Concerns
  module AuthorizeInvite
    extend ActiveSupport::Concern

    included do
      before_action :doorkeeper_authorize!
    end
  end
end
