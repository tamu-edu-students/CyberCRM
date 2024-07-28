# frozen_string_literal: true

# This preloads super users
class PreloadSuperUsers < ActiveRecord::Migration[6.0]
  def up
    # Define the users you want to preload
    users = [
      { email: 'willtaaa@tamu.edu', role: 'super_user' },
      { email: 'noamgariani@tamu.edu', role: 'super_user' },
      { email: 'pcannell512@tamu.edu', role: 'super_user' },
      { email: 'matthewatanas@tamu.edu', role: 'super_user' },
      { email: 'chrisvmuniz@tamu.edu', role: 'super_user' },
      { email: 'pcr@tamu.edu', role: 'super_user' },
      { email: 'john.romero@tamu.edu', role: 'super_user' }
    ]

    # Create each user
    users.each do |user_data|
      User.create!(
        email: user_data[:email],
        role: user_data[:role],
        role_list: ['super_user', 'program_director', 'student_worker'],
        provider: 'preloaded',
        uid: SecureRandom.uuid,
        name: 'preloaded'
      )
    end
  end

  def down
    # Remove the preloaded users
    emails = ['admin1@example.com', 'admin2@example.com', 'admin3@example.com']
    User.where(email: emails).destroy_all
  end
end
