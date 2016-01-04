module Concerns
  module AuthorizeGuest
    extend ActiveSupport::Concern

    included do
      before_action :doorkeeper_authorize!
    end
  end
end
