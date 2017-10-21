Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#main'

  # resources :review, except: [:index, :new]

  resources :products do
    resources :reviews, only: [:index, :new]
  end

  resources :merchants
  resources :categories, only: [:index, :show]
  resources :orders
  resources :order_products

  get '/auth/:provider/callback', to: 'sessions#login', as: 'auth_callback'
  post '/logout', to: 'sessions#logout', as: 'logout'

  get '/add_to_cart', to: 'orders#add_to_cart'
  post '/add_to_cart', to: 'orders#add_to_cart'
end
