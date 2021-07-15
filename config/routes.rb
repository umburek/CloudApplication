require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  devise_for :users
  mount Sidekiq::Web => '/sidekiq'

  resources :quotes, only: [:new, :create]
  resource :vote, only: [:new, :create]
  resources :clouds, only: [:new]

  root to: 'quotes#new'
end