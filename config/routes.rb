Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#root'


  resources :categories
  resources :merchants
  resources :orders
  resources :products
  resources :reviews

  patch 'products/:id/add_product_to_cart', to: 'products#add_product_to_cart', as: 'add_product'

end
