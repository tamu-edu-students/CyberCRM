# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV.fetch('GOOGLE_CLIENT_ID'), ENV.fetch('GOOGLE_CLIENT_SECRET'), {
    scope: 'email,profile',
    prompt: 'select_account',
    access_type: 'offline'
  }
end

OmniAuth.config.allowed_request_methods = [:post, :get]
