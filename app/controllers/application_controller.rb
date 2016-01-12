class ApplicationController < ActionController::API
  include Concerns::CurrentBasket
  include Concerns::CurrentGuest
  include Concerns::CurrentInvite
  include Concerns::ExceptionHandler
end
