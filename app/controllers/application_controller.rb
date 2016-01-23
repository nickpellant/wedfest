class ApplicationController < ActionController::API
  include Concerns::CurrentBasket
  include Concerns::CurrentInvite
  include Concerns::ExceptionHandler
end
