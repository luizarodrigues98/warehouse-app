Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :warehouses, except: [:index]
  resources :suppliers
  resources :product_models, except: [:destroy]
  resources :orders, only: [:new, :create, :show]
end