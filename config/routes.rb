Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "main#index"
  get "/auth/:provider/callback", to: "merchants#login"

  resources :merchants, except: [:index, :new] do
    resources :orders, only: [:index]
    resources :order_products, only:[:index], as: 'sold'
  end

  resources :orders, except: [:edit]
  resources :order_products, only: [:update, :destroy]
  resources :products
  resources :reviews, except: [:index, :show]
end
