Rails.application.routes.draw do
  resources :products
  resources :merchants
  resources :categories 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#main'
end
