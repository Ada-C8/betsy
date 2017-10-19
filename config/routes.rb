Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'products#home', as: "root"


  resources :categories
  resources :merchants do
    get '/products', to: 'products#index'
  end
  resources :orders
  resources :products
  resources :reviews

  patch 'products/:id/add_product_to_cart', to: 'products#add_product_to_cart', as: 'add_product'

end
