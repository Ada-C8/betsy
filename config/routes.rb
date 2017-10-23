Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'products#root', as: "root"
  get '/home', to: 'products#home', as: "home"


  resources :products do
    resources :reviews, only: [:new, :create]

   end

  resources :merchants do
    get '/products', to: 'products#index'
  end

  resources :categories do
    resources :products, only: [:index]
  end

  resources :orders, except: [:destroy] do
    get '/orders/:id/confirm', to: 'orders#confirm', as: 'confirm_order'
  end

  get "/auth/:provider/callback", to: "sessions#create"

  patch 'products/:id/add_product_to_cart', to: 'products#add_product_to_cart', as: 'add_product'

  patch 'products/:id/remove_product_from_cart', to: 'products#remove_product_from_cart', as: 'remove_product'

  # resources :merchants do
  #   get '/products', to: 'products#index'
  # end
  #
  # resources :categories, except: [:edit] do
  #   get '/products', to: 'products#index'
  # end

end
