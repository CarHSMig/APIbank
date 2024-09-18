Rails.application.routes.draw do
  resources :transactions
  resources :accounts
  resources :accounts do
    resources :transactions, only: [ :index, :create, :show ]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  direct :rails_blob do |blob, options|
    route_for(:rails_blob, blob, options.merge(only_path: true))
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
