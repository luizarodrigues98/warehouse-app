Rails.application.routes.draw do
  root to: 'home#index'
  resources :warehouses, except: [:index]
  resources :suppliers
  resources :product_models, only: [:index]
end