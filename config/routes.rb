Rails.application.routes.draw do
  namespace :api do
    resources :accommodations, only: %i(index)
    resources :basket_items, only: %i(create show)
    resources :guests, only: %i(index show update)
    resources :invites, only: %i(index)
  end
end
