Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'products#home', as: "root"

  resources :categories
  resources :orders

  resources :products do
    resources :reviews
   end

  resources :merchants do
    get '/products', to: 'products#index'
  end
  
  resources :categories do
    resources :products, only: [:index]
  end

  patch 'products/:id/add_product_to_cart', to: 'products#add_product_to_cart', as: 'add_product'

  patch 'products/:id/remove_product_from_cart', to: 'products#remove_product_from_cart', as: 'remove_product'


end
