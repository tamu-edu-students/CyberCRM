# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OptionsController, type: :controller do
  let(:valid_attributes) do
    { field: 'Gender', display_type: 'dropdown', options: 'Male,Female' }
  end

  let(:invalid_attributes) do
    { field: nil, display_type: nil, options: nil }
  end

  let!(:option) { Option.create! valid_attributes }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: option.to_param }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { options: 'Male,Female,Non-binary' }
      end

      it 'updates the requested option' do
        put :update, params: { id: option.to_param, option: new_attributes }
        option.reload
        expect(option.options).to eq('Male,Female,Non-binary')
      end

      it 'redirects to the options list' do
        put :update, params: { id: option.to_param, option: new_attributes }
        expect(response).to redirect_to(options_path)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e., to display the 'edit' template)" do
        put :update, params: { id: option.to_param, option: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested option' do
      expect do
        delete :destroy, params: { id: option.to_param }
      end.to change(Option, :count).by(-1)
    end

    it 'redirects to the options list' do
      delete :destroy, params: { id: option.to_param }
      expect(response).to redirect_to(options_path)
    end
  end

  describe 'POST #add_option_to_field' do
    context 'with valid params' do
      let(:field) { 'Gender' }
      let(:new_option) { 'Non-binary' }

      before do
        post :add_option_to_field, params: { option: { field:, options: new_option } }
      end

      it 'adds a new option to the field' do
        option.reload
        expect(option.options).to include(new_option)
      end

      it 'redirects to the options list with a notice' do
        expect(response).to redirect_to(options_path)
        expect(flash[:notice]).to eq('Option was successfully updated.')
      end
    end

    context 'with invalid params' do
      it 'redirects to the options list with an alert' do
        post :add_option_to_field, params: { option: { field: '', options: '' } }
        expect(response).to redirect_to(options_path)
        expect(flash[:alert]).to eq('Field and new option must be present.')
      end
    end
  end
end
