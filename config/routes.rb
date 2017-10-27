Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "main#index"
  get "/auth/:provider/callback", to: "merchants#login", as: 'login'
  get '/logout', to: 'merchants#logout', as: 'logout'
  resources :merchants, except: [:index, :new] do
    resources :orders, only: [:index]
    resources :order_products, only:[:index], as: 'sold'
  end

  resources :orders
  resources :order_products, only: [:update, :destroy]
  get '/products/:id/categories', to: 'categories#add', as: 'add_categories'
  post '/products/:id/categories', to: 'products#add_categories'
  post '/products/:id/new_category', to: 'categories#create'
  resources :products
  resources :categories, only: [:new, :create, :destroy] do
    resources :products, only: [:index]
  end

  resources :products do
    resources :reviews, only: [:new]
  end
  resources :reviews, only: [:create, :edit, :update, :destroy]

  post '/products/:id', to: 'main#add_to_cart', as: 'add_to_cart'
  get '/cart', to: 'main#shopping_cart', as: 'shopping_cart'

  # User pages
  get '/home', to: 'merchants#summary', as: 'self_summary'
  get '/pending', to: 'merchants#pending', as: 'self_pending'
  get '/completed', to: 'merchants#completed', as: 'self_completed'
  get '/revenue', to: 'merchants#revenue', as: 'self_revenue'
  get '/inventory', to: 'merchants#inventory', as: 'self_inventory'

  get '/:id/mark_shipped', to: 'merchants#mark_shipped', as: 'mark_shipped'
  get '/:id/retire', to: 'products#retire', as: 'retire_product'

  get '/confirmation/:id', to: 'orders#confirmation', as: 'confirmation'

  # Order cancel
  get '/:id/cancel', to: 'orders#cancel', as: 'cancel'
end
