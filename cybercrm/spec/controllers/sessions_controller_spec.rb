# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController do
  describe 'POST #create' do
    let(:auth) do
      OmniAuth::AuthHash.new(
        provider: 'google_oauth2',
        uid: '123545',
        info: {
          name: 'John Doe',
          email: 'john.doe@example.com',
          image: 'http://example.com/image.jpg'
        },
        credentials: {
          token: 'token',
          refresh_token: 'another_token',
          expires_at: 1.week.from_now.to_i
        }
      )
    end

    before do
      request.env['omniauth.auth'] = auth
    end

    context 'when the user is persisted' do
      let!(:user) { create(:user, provider: 'google_oauth2', uid: '123545', email: 'john.doe@example.com') }

      it 'sets the session user_id and redirects to the home page with a notice' do
        post :create, params: { provider: 'google_oauth2' }
        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to(pages_home_path)
        expect(flash[:notice]).to eq(I18n.t('signed_in'))
      end
    end

    context 'when the user is not persisted' do
      context 'with an unlisted email' do
        let(:unlisted_email) { 'unlisted@example.com' }

        before do
          request.env['omniauth.auth'].info.email = unlisted_email
        end

        it 'redirects to the root path with an alert' do
          post :create, params: { provider: 'google_oauth2' }
          expect(response).to redirect_to(root_path)
          expect(flash[:alert]).to eq(I18n.t('failure'))
        end
      end

      context 'with a listed email' do
        let(:listed_email) { 'willtaaa@tamu.edu' }

        before do
          request.env['omniauth.auth'].info.email = listed_email
        end

        it 'redirects to the home page with a notice' do
          post :create, params: { provider: 'google_oauth2' }
          expect(response).to redirect_to(pages_home_path)
          expect(flash[:notice]).to eq(I18n.t('signed_in'))
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      session[:user_id] = 1
    end

    it 'clears the session and redirects to the root path with a notice' do
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq(I18n.t('signed_out'))
    end
  end
end
