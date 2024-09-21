Rails.application.routes.draw do
  resources :accounts, only: [ :create, :show, :index] do
    resources :transactions, only: [ :index, :create, :show ]
  end

  direct :rails_blob do |blob, options|
    route_for(:rails_blob, blob, options.merge(only_path: true))
  end

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
