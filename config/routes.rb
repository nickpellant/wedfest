Rails.application.routes.draw do
  namespace :api do
    resources :invites, only: %i(index)
  end
end
