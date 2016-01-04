class ApplicationController < ActionController::API
  include Concerns::CurrentGuest
  include Concerns::ExceptionHandler
end
