Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#main'

  resources :products
  resources :merchants
  resources :categories
  resources :orders
  resources :order_products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'products#main'
  get    '/login',   to: 'sessions#login'
  post   '/login',   to: 'sessions#create'
  post   '/logout',  to: 'sessions#logout'
end
