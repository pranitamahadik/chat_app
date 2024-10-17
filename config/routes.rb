require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users,  defaults: { format: :json }, controllers: {
        registrations: 'users/registrations',
        sessions: 'users/sessions',
        passwords: 'users/passwords'
      }
  namespace :api, defaults: {format: 'json'}  do
    namespace :v1 do
      
      resources :chat_rooms, only: [:index, :create] do
        resources :messages, only: [:create]
      end
      resources :direct_messages, only: [:index, :create]
      get 'users/online_status', to: 'users#online_status'
    end

  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  mount ActionCable.server => '/cable'
  mount Sidekiq::Web => '/sidekiq'
  # Defines the root path route ("/")
  # root "posts#index"
end
