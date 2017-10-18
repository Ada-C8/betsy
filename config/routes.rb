Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'main#index'

  resources :products
  resources :merchants
  get    '/login',   to: 'sessions#login'
  post   '/login',   to: 'sessions#create'
  post   '/logout',  to: 'sessions#logout'
end
