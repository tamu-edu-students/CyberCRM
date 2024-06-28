# frozen_string_literal: true

Devise.setup do |config|
  config.omniauth :google_oauth2, ENV.fetch('GOOGLE_CLIENT_ID', nil), ENV.fetch('GOOGLE_CLIENT_SECRET', nil), {
    scope: 'email,profile',
    prompt: 'select_account',
    access_type: 'offline',
    redirect_uri: 'http://localhost:3000/auth/google_oauth2/callback'
  }
end
