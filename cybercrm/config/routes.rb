Rails.application.routes.draw do
  root 'sessions#new'
  get 'home/index'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: redirect('/')
  get '/logout', to: 'sessions#destroy'
  get 'up' => 'rails/health#show', as: :rails_health_check
end
