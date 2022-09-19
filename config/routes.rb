Rails.application.routes.draw do
  root to: 'home#index'
  resources :warehouses, except: [:index]
  resources :suppliers, only: [:index, :show, :new, :create, :edit, :update ]
end