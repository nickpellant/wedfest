Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :applications, :authorized_applications
  end

  namespace :api do
    resources :accommodations, only: %i(index)
    resources :basket_items, only: %i(create show update)
    resources :baskets, only: %i(show)
    resources :guests, only: %i(index show update)
    resources :invites, only: %i(index)
    resources :orders, only: %i(create)
  end
end
