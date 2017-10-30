Rails.application.routes.draw do

  root 'static_pages#home'

  get "/products/category/", to: "products#by_category", as: 'products_by_category'

  get "/products/merchant/", to: "products#by_merchant", as: 'products_by_merchant'

  get "/users/:id/orders", to: "users#order_fulfillment", as: 'order_fulfillment' #order_fulfillment_path

  get "/users/:user_id/orders/:id", to: "orders#user_order",as: "user_order"

  resources :products do
    resources :reviews, only: [:new, :create]
    resources :order_items, only: [:new, :create]
  end

  resources :carts, except: [:destroy, :index, :new]

  resources :order_items, except: [:new, :create]

  resources :users do
    resources :orders, only: [:index]
    resources :order_items, only: [:index, :show, :edit, :update]
  end

  resources :users, only: [:index, :show, :edit, :update]

  resources :reviews, except: [:new, :create]

  resources :orders
  patch '/orders', to: 'orders#place_order', as: 'place_order'

  get '/login', to: 'sessions#login_form', as: 'login'
  post '/login', to: 'sessions#login'
  post '/logout', to: 'sessions#logout', as: 'logout'

  get "/auth/:provider/callback", to: "sessions#create", as: "auth_callback"

  get '/users/:id/products', to: 'users#account', as: 'user_account'

  resources :categories, only: [:create, :new, :index] do
    get '/products', to: 'product#index'
  end

  patch '/order_item/:id/mark_shipped', to: 'order_items#mark_shipped', as: 'item_shipped'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
