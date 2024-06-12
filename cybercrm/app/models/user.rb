class User < ApplicationRecord
    # Validations
    validates :provider, :uid, :name, :email, presence: true
    validates :email, uniqueness: true

    # Method to find or create a user from OmniAuth data
    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.name = auth.info.name
            user.email = auth.info.email
            user.image = auth.info.image
            user.save
        end
    end
end