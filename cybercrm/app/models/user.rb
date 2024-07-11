# frozen_string_literal: true

# This is user < application record
class User < ApplicationRecord
  # Validations
  # https://guides.rubyonrails.org/testing.html

  # presence ensures that it is not nil
  validates :provider, :uid, :name, :email, :role, presence: true

  # uniqueness ensures that it is unique across users
  validates :email, uniqueness: true

  # Method to find or create a user from OmniAuth data
  # Used ChatGPT to rewrite this for preloading a user
  # the prompt was basically asking it to modify this to work
  # with my user creation and handle the different cases of user state
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_initialize
    existing_user_with_email = User.find_by(email: auth.info.email)

    if user.persisted?
      # User exists with provider and uid
      user.update!(
        name: auth.info.name,
        image: auth.info.image,
        email: auth.info.email
      )
    elsif existing_user_with_email
      # User exists with the same email
      existing_user_with_email.update!(
        provider: auth.provider,
        uid: auth.uid,
        name: auth.info.name,
        image: auth.info.image
      )
      user = existing_user_with_email
    else
      # New user
      user.assign_attributes(
        email: auth.info.email,
        name: auth.info.name,
        image: auth.info.image,
        role: 'student_worker'
      )
      user.save!
    end
    user
  end
end
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize
