# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable RSpec/MultipleExpectations
RSpec.describe UsersController do
  describe 'POST #create' do
    context 'when as a super user' do
      let(:super_user) { create(:user, role: 'super_user') }
      let(:valid_attributes) { { email: 'test@example.com', role: 'admin' } }

      before do
        allow(controller).to receive(:current_user).and_return(super_user)
      end

      it 'permits :email and :role attributes' do
        post :create, params: { user: valid_attributes }
        expect(assigns(:user).email).to eq('test@example.com')
        expect(assigns(:user).role).to eq('admin')
      end
    end

    context 'when as a regular user' do
      let(:regular_user) { create(:user, role: 'regular_user') }
      let(:valid_attributes) { { email: 'test@example.com' } }

      before do
        allow(controller).to receive(:current_user).and_return(regular_user)
      end

      it 'redirects to root path with an unauthorized alert' do
        post :create, params: { user: valid_attributes.merge(role: 'admin') }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq(I18n.t('unauthorized'))
      end
    end
  end

  describe 'PUT #update' do
    let(:user) { create(:user) }

    context 'when as a super user' do
      let(:super_user) { create(:user, role: 'super_user') }
      let(:valid_attributes) { { email: 'updated@example.com', role: 'admin' } }

      before do
        allow(controller).to receive(:current_user).and_return(super_user)
      end

      it 'permits :email and :role attributes' do
        put :update, params: { id: user.to_param, user: valid_attributes }
        user.reload
        expect(user.email).to eq('updated@example.com')
        expect(user.role).to eq('admin')
      end
    end

    context 'when as a regular user' do
      let(:regular_user) { create(:user, role: 'regular_user') }
      let(:valid_attributes) { { email: 'updated@example.com' } }

      before do
        allow(controller).to receive(:current_user).and_return(regular_user)
      end

      it 'redirects to root path with an unauthorized alert' do
        put :update, params: { id: user.to_param, user: valid_attributes.merge(role: 'admin') }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq(I18n.t('unauthorized'))
      end
    end
  end
end
# rubocop:enable RSpec/MultipleExpectations
