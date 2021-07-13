Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'

  Rails.application.routes.draw do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  resources :quotes, only: [:new, :create]
  resource :vote, only: [:new, :create]
  resources :clouds, only: [:new]

  root to: 'quotes#new'
end
