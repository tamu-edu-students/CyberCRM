# frozen_string_literal: true

# features/support/omniauth_helper.rb
module OmniauthHelper
  def login_with_google_oauth2
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid: '123545',
      info: {
        name: 'John Doe',
        email: 'john.doe@example.com'
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

  def test_user
    User.find_by(email: 'john.doe@example.com')
  end

  def test_user1
    User.find_by(email: 'user1@example.com')
  end

  def test_user2
    User.find_by(email: 'user2@example.com')
  end

end

World(OmniauthHelper)
