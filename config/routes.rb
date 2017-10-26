Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#main'

  # resources :review, except: [:index, :new]

  resources :products do
    resources :reviews, only: [:index, :new, :create]
  end

  resources :merchants
  resources :categories
  resources :orders
  resources :orders_products

  get '/auth/:provider/callback', to: 'sessions#login', as: 'auth_callback'
  post '/logout', to: 'sessions#logout', as: 'logout'
  post '/add_to_cart/:id', to: 'orders#add_to_cart', as: 'add_to_cart'
  get '/billing_form', to: 'orders#billing_form'
  post '/show_order/:id', to: 'orders#submit', as: 'show_order'
end
