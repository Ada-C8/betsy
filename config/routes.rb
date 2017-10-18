Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :orders
  resources :products
  resources :merchants
  resources :reviews, only: [:new, :create]
  # nested route /product/:id/review 
end
