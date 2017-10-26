Rails.application.routes.draw do

  root 'products#root'

  # resources :order_products
  get '/users/:user_id/products', to: 'products#index', as: 'user_products'
  get '/users/:user_id/orders', to: 'users#order_fulfillment', as: 'user_orders'
  get '/about', to: 'users#about'
  get '/shipping', to: 'users#shipping'
  get '/orders/lookup', to: 'orders#lookup'
  get '/orders/found', to: 'orders#found'

  resources :categories, only: [:new, :create, :index] do
    resources :products, only: [:index]
  end

  resources :products do
    resources :reviews, only: [:new, :create]
  end

  resources :users do
    resources :products, only: [:index]
  end

  resources :orders

  patch '/order_products/:id/cancel', to: 'order_products#cancel', as: 'cancel_order_product'
  patch '/order_products/:id/shipped', to: 'order_products#shipped', as: 'ship_order_product'
  patch 'products/:id/toggle_active', to: 'products#toggle_active', as: 'toggle_active'
  post '/products/:id/order', to: 'order_products#create', as: 'order_products'
  get '/order_products/:id/edit', to: 'order_products#edit', as: 'edit_order_product'
  delete '/order_products/:id', to: 'order_products#destroy', as: 'order_product'
  patch '/order_products/:id', to: 'order_products#update'

  #get '/login', to: 'users#create'

  get '/auth/:provider/callback', to: 'users#login'
  delete '/logout', to: 'users#logout'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
