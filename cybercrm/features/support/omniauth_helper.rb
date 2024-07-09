# frozen_string_literal: true

# features/support/omniauth_helper.rb
module OmniauthHelper
  def login_with_google_oauth2
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(Faker::Omniauth.google)
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    post '/auth/google_oauth2'
    follow_redirect!
  end
end

World(OmniauthHelper)
