Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  resources :products
  resources :merchants

  resources :orders
  resources :reviews
  root 'main#index'

  resources :order_items, only: [:create, :index, :destroy, :update]


  resources :categories, only: [:create, :index]

  # nested routes
  resources :categories do
    resources :products, only: [:index]
  end

  resources :merchants do
    resources :products, only: [:index]
  end

  resources :merchants do
    resources :categories, only: [:index, :new]
  end

  resources :merchants do
    resources :categories, only: [:show] do
      resources :products, only: [:index]
    end
  end

  get '/products/merchant/:id', to: 'products#index_by_merchant', as: 'products_merchant'

  get '/products/category/:id', to: 'products#index_by_category', as: 'products_category'

  get '/auth/:provider/callback', to: 'merchants#login', as: 'auth_callback'

  get 'logout', to: 'merchants#logout', as: 'logout'

end
