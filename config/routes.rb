Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#main'

  resources :review, except: [:index, :new]

  resources :products do
    resources :reviews, only: [:index, :new]
  end

  resources :merchants
  resources :categories
  resources :orders
  resources :order_products


  get '/auth/:provider/callback', to: 'sessions#login'
  post   '/login',   to: 'sessions#create'
  post   '/logout',  to: 'sessions#logout'
end
