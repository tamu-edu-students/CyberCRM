# frozen_string_literal: true

Rails.application.routes.draw do
  resources :students do
    collection do
      post :search
      get :export_csv
    end
  end

  root 'pages#login'

  get 'pages/home'
  get 'pages/form'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: redirect('/')
  get '/logout', to: 'sessions#destroy'
  post 'search_students', to: 'students#search'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
