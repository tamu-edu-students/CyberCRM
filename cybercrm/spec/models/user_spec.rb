# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:provider) }
    it { is_expected.to validate_presence_of(:uid) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:role) }
  end

  describe '.from_omniauth' do
    let(:auth) do
      OmniAuth::AuthHash.new(
        provider: 'google_oauth2',
        uid: '123545',
        info: {
          name: 'John Doe',
          email: 'john.doe@example.com',
          image: 'http://example.com/image.jpg'
        }
      )
    end

    context 'when user does not exist' do
      it 'creates a new user' do
        expect do
          described_class.from_omniauth(auth)
        end.to change(described_class, :count).by(1)

        user = described_class.last
        expect(user.provider).to eq('google_oauth2')
        expect(user.uid).to eq('123545')
        expect(user.name).to eq('John Doe')
        expect(user.email).to eq('john.doe@example.com')
        expect(user.image).to eq('http://example.com/image.jpg')
        expect(user.role).to eq('student_worker')
      end
    end

    context 'when user exists with provider and uid' do
      let!(:user) { create(:user, provider: 'google_oauth2', uid: '123545', email: 'john.doe@example.com') }

      it 'updates the user info' do
        updated_user = described_class.from_omniauth(auth)
        expect(updated_user.name).to eq('John Doe')
        expect(updated_user.image).to eq('http://example.com/image.jpg')
        expect(updated_user.email).to eq('john.doe@example.com')
      end
    end

    context 'when user exists with the same email' do
      let!(:existing_user) { create(:user, email: 'john.doe@example.com', provider: 'facebook', uid: '54321') }

      it 'updates the existing user with provider and uid and returns it' do
        expect do
          described_class.from_omniauth(auth)
        end.not_to change(described_class, :count)

        updated_user = described_class.from_omniauth(auth)
        expect(updated_user.provider).to eq('google_oauth2')
        expect(updated_user.uid).to eq('123545')
        expect(updated_user.name).to eq('John Doe')
        expect(updated_user.image).to eq('http://example.com/image.jpg')
        expect(updated_user.email).to eq('john.doe@example.com')
      end
    end
  end
end
