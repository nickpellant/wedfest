Rails.application.routes.draw do
  namespace :api do
    resources :guests, only: %i(index show)
    resources :invites, only: %i(index)
  end
end
