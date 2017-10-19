Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "main#index"
  get "/auth/:provider/callback", to: "merchants#login"

  # temporary! Replace this with actual, thought out routes
  resources :merchants, :orders, :order_products, :products, :reviews
end
