require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  devise_for :users
  mount Sidekiq::Web => '/sidekiq'

  resources :quotes, only: [:new, :create, :destroy]
  resource :vote, only: [:new, :create]
  resources :clouds, only: [:new]
  resource :send_cloud_image_mail, controller: 'send_cloud_image_mail', only: :create

  root to: 'quotes#new'
end