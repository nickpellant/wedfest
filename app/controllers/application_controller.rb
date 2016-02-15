class ApplicationController < ActionController::API
  include Concerns::CurrentBasket
  include Concerns::CurrentInvite
  include Concerns::ExceptionHandler

  serialization_scope :current_invite
end
