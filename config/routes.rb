Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :restaurants do
    resources :tables, only: [ :index, :show, :new, :create ]
    resources :products, only: [ :index, :show, :new, :create ]
    resources :expenses, only: [ :index, :show, :new, :create ]
  end
  resources :tables, only: [ :edit, :update, :destroy ]
  resources :products, only: [ :edit, :update, :destroy ]
  resources :expenses, only: [ :edit, :update, :destroy ]
end
