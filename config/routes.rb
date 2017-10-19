Rails.application.routes.draw do

  root 'products#root'

  # resources :order_products

  resources :products do
    resources :reviews, only: [:new, :create]
  end

  resources :categories do
    resources :products
  end

  resources :users

  resources :orders

  post '/products/:id/order', to: 'order_products#create', as: 'order_products'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
