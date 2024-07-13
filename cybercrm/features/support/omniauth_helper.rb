# frozen_string_literal: true

# features/support/omniauth_helper.rb
require 'faker'

# rubocop:disable Metrics/AbcSize
# omniauth helper
module OmniauthHelper
  def login_with_google_oauth2
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid: Faker::Number.number(digits: 10),
      info: {
        name: Faker::Name.name,
        email: Faker::Internet.email
      },
      credentials: {
        token: 'token',
        refresh_token: 'another_token',
        expires_at: 1.week.from_now
      }
    )
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    # Trigger the OmniAuth callback
    get '/auth/google_oauth2/callback'
    follow_redirect!
  end

  def test_user(role:)
    auth = OmniAuth.config.mock_auth[:google_oauth2]
    user = User.find_or_create_by(email: auth[:info][:email]) do |u|
      u.name = auth[:info][:name]
      u.provider = auth[:provider]
      u.uid = auth[:uid]
      u.role = role
    end
    user.update(role:)
    user
  end
end

World(OmniauthHelper)
# rubocop:enable Metrics/AbcSize
