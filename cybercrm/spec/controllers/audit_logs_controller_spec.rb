# spec/controllers/audit_logs_controller_spec.rb
require 'rails_helper'

RSpec.describe AuditLogsController, type: :controller do
  let(:super_user) { create(:user, role: 'super_user') }
  let(:regular_user) { create(:user, role: 'student_worker') }

  before do
    # Mocking the current_user method to return the super_user
    allow(controller).to receive(:current_user).and_return(super_user)
  end

  describe 'GET #index' do
    it 'returns http success for super_user' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'redirects regular user to root' do
      allow(controller).to receive(:current_user).and_return(regular_user)
      get :index
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq(I18n.t('unauthorized'))
    end
  end

  describe 'GET #users' do
    it 'renders the users partial' do
      get :users
      expect(response).to render_template(partial: '_users')
    end
  end

  describe 'GET #students' do
    it 'renders the students partial' do
      get :students
      expect(response).to render_template(partial: '_students')
    end
  end

  describe 'GET #options' do
    it 'renders the options partial' do
      get :options
      expect(response).to render_template(partial: '_options')
    end
  end

  describe 'GET #notes' do
    it 'renders the notes partial' do
      get :notes
      expect(response).to render_template(partial: '_notes')
    end
  end

  describe 'GET #student_options' do
    it 'renders the student_options partial' do
      get :student_options
      expect(response).to render_template(partial: '_student_options')
    end
  end
end
