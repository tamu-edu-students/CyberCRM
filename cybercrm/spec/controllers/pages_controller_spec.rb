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

  describe 'POST #update_role' do
    let(:user) { create(:user, role_list: ['user', 'admin']) }

    before do
      sign_in user
    end

    it 'updates the role of the user' do
      post :update_role, params: { role: 'admin' }
      expect(user.reload.role).to eq('admin')
      expect(response).to redirect_to(root_path)
    end

    it 'does not update the role if not in role list' do
      post :update_role, params: { role: 'super_user' }
      expect(user.reload.role).not_to eq('super_user')
      expect(response).to redirect_to(root_path)
    end
  end
end
