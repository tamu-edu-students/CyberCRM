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
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.image = auth.info.image
      user.role = 'student_worker'
      user.save!
    end
  end
end
