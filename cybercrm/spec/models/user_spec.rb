# frozen_string_literal: true
# generated with ChatGPT
# prompt can you make an rspec
# user model code

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:provider) }
    it { should validate_presence_of(:uid) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:role) }
  end

  describe '.from_omniauth' do
    let(:auth) do
      OmniAuth::AuthHash.new(
        provider: 'google',
        uid: '123545',
        info: {
          name: 'John Doe',
          email: 'john.doe@example.com',
          image: 'http://example.com/image.jpg'
        }
      )
    end

    it 'creates a new user if one does not exist' do
      expect {
        User.from_omniauth(auth)
      }.to change(User, :count).by(1)

      user = User.last
      expect(user.provider).to eq('google')
      expect(user.uid).to eq('123545')
      expect(user.name).to eq('John Doe')
      expect(user.email).to eq('john.doe@example.com')
      expect(user.image).to eq('http://example.com/image.jpg')
      expect(user.role).to eq('student_worker')
    end

    it 'finds an existing user if one already exists' do
      existing_user = User.create!(
        provider: 'google',
        uid: '123545',
        name: 'Existing User',
        email: 'existing.user@example.com',
        role: 'student_worker'
      )

      expect {
        User.from_omniauth(auth)
      }.not_to change(User, :count)

      user = User.last
      expect(user).to eq(existing_user)
      expect(user.name).to eq('Existing User')
      expect(user.email).to eq('existing.user@example.com')
      expect(user.role).to eq('student_worker')
    end
  end
end