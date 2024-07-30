# spec/controllers/pages_controller_spec.rb
require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'GET #login' do
    it 'returns a success response' do
      get :login
      expect(response).to be_successful
    end
  end

  describe 'GET #form' do
    it 'returns a success response' do
      get :form
      expect(response).to be_successful
    end
  end

  describe 'GET #home' do
    it 'returns a success response' do
      get :home
      expect(response).to be_successful
    end
  end


  let(:user) { create(:user) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'PATCH #update_role' do
    context 'when the new role is in the sanitized role list' do
      let(:new_role) { 'program_director' }

      before do
        user.update(role_list: ['user', 'program_director', ''])
        patch :update_role, params: { role: new_role }
      end

      it 'updates the user\'s role' do
        user.reload
        expect(user.role).to eq(new_role)
      end

      it 'sets a notice flash message' do
        expect(flash[:notice]).to eq(I18n.t('role_updated'))
      end

      it 'redirects to the fallback location' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when the new role is not in the sanitized role list' do
      let(:new_role) { 'super_user' }

      before do
        user.update(role_list: ['user', 'program_director', ''])
        patch :update_role, params: { role: new_role }
      end

      it 'does not update the user\'s role' do
        user.reload
        expect(user.role).not_to eq(new_role)
      end

      it 'sets an alert flash message' do
        expect(flash[:alert]).to eq(I18n.t('role_alert'))
      end

      it 'redirects to the fallback location' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
  
  
end
