Rails.application.routes.draw do
  namespace :api do
    resources :guests, only: %i(index)
    resources :invites, only: %i(index)
  end
end
