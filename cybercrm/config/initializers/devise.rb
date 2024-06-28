Devise.setup do |config|
    config.omniauth :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
      scope: 'email,profile',
      prompt: 'select_account',
      access_type: 'offline',
      redirect_uri: 'http://localhost:3000/auth/google_oauth2/callback'
    }
  end
  