Rails.application.routes.draw do
  devise_for :users
  root 'wikis#index'
  get '/welcome' => 'welcome#index'

  resources :wikis
  resources :users, only: [:update]

  resources :charges, only: [:new, :create]
  resources :subscriptions, only: [:new, :create, :destroy]

end
