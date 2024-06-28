# frozen_string_literal: true

Rails.application.routes.draw do
  resources :students do
    collection do
      get :export_csv
    end
  end

  # Set the root path to the login page
  root 'pages#login'

  # Define the pages routes with named helpers
  get 'home', to: 'pages#home', as: 'home'
  get 'login', to: 'pages#login', as: 'login'
  get 'spreadsheet', to: 'pages#spreadsheet', as: 'spreadsheet'
  get 'student_detail', to: 'pages#student_detail', as: 'student_detail'
  get 'failure', to: 'pages#failure', as: 'failure'

  # OmniAuth callback routes
  match '/auth/:provider/callback', to: 'sessions#create', via: %i[get post]
  get '/auth/failure', to: redirect('/')

  # Logout route
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  # Health check route
  get 'up' => 'rails/health#show', as: :rails_health_check
end
