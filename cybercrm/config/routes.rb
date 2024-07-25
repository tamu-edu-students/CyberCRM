# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  resources :notes

  resources :options do
    post :add_option_to_field, on: :collection
  end

  resources :students do
    collection do
      post :search
      post :import
      get :export_csv
      get :inactive
    end

    member do
      post :update_custom_attribute
    end
  end

  resources :custom_attributes, except: :show do
    member do
      post :toggle_active
    end
  end

  resources :users, only: %i[index show edit update destroy new create]

  root 'pages#login'

  get 'pages/home'
  get 'pages/form'

  get 'custom_attributes/index'
  get 'custom_attributes/new'
  get 'custom_attributes/edit'
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
# rubocop:enable Metrics/BlockLength
