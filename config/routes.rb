Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "main#index"
  get "/auth/:provider/callback", to: "merchants#login", as: 'login'
  get '/logout', to: 'merchants#logout', as: 'logout'
  resources :merchants, except: [:index, :new] do
    resources :orders, only: [:index]
    resources :order_products, only:[:index], as: 'sold'
  end

  resources :orders, except: [:edit]
  resources :order_products, only: [:update, :destroy]
  get '/products/:id/categories', to: 'products#categories', as: 'add_categories'
  post '/products/:id/categories', to: 'products#add_categories'
  post '/products/:id/new_category', to: 'categories#create'
  resources :products
  resources :categories, only: [:new, :create, :destroy] do
    resources :products, only: [:index]
  end
  resources :reviews, except: [:index, :show]
  resources :products do
    # only: [:index, :new, :create] is nested
    resources :reviews, shallow: true
  end
end
