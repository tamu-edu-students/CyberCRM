# frozen_string_literal: true

class User < ApplicationRecord
  # Method to find or create a user from OmniAuth data
  # Used ChatGPT to rewrite this for preloading a user
  # the prompt was basically asking it to modify this to work
  # with my user creation and handle the different cases of user state
  validates :provider, :uid, :email, :role, presence: true
  validates :name, presence: true, length: { minimum: 4, maximum: 200 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

  def self.from_omniauth(auth)
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)

    if user.persisted?
      update_existing_user(user, auth.info)
    else
      handle_new_user(user, auth.info)
    end

    user
  end

  def self.update_existing_user(user, auth_info)
    existing_user_with_email = find_by(email: auth_info.email)

    if existing_user_with_email && existing_user_with_email != user
      existing_user_with_email.update!(
        provider: user.provider,
        uid: user.uid,
        name: auth_info.name,
        image: auth_info.image
      )
      existing_user_with_email
    else
      user.update!(
        name: auth_info.name,
        image: auth_info.image,
        email: auth_info.email
      )
    end
  end

  def self.handle_new_user(user, auth_info)
    user.assign_attributes(
      email: auth_info.email,
      name: auth_info.name,
      image: auth_info.image,
      role: 'student_worker'
    )
    user.save!
  end
end
