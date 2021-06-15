Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
    get '/about', to: 'pages#about', as: 'about'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :restaurants do
    resources :tables, only: [ :index ]
    resources :products, only: [ :index, :show, :new, :create ]
    resources :expenses, only: [ :index, :show, :new, :create ]
    resources :order_items, only: [:index]
    get '/spaces/:number/tables/new', to: 'tables#new', as: 'table_new'
    get '/spaces/:number/tables/create', to: 'tables#create', as: 'table_create'
    get '/spaces/:number/tables/:id', to: 'tables#show', as: 'table_show'
    get '/tables/:id/close', to: 'tables#close', as: 'table_close'
    get '/cashflow', to: 'restaurants#cashflow', as: 'cashflow'
    resources :terminals, only: [ :index, :show, :new, :create ]
  end
  resources :tables, only: [:update] do
    resources :order_items, only: [:create]
  end
  resources :products, only: [ :edit, :update, :destroy ]
  resources :expenses, only: [ :edit, :update, :destroy ]
  resources :order_items, only: [:destroy]
  resources :terminals, only: [ :edit, :update, :destroy ]
end
