# frozen_string_literal: true

require 'rails_helper'
RSpec.describe OptionsController, type: :controller do
  let(:valid_attributes) do
    { field: 'Gender', display_type: 'dropdown', options: 'Male,Female' }
  end

  let(:invalid_attributes) do
    { field: nil, display_type: nil, options: nil }
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Option' do
        expect do
          post :create, params: { option: valid_attributes }
          expect(response).to have_http_status(:found) # ensure the response status is a redirect
          expect(response).to redirect_to(options_path) # ensure it redirects to the options list
        end.to change(Option, :count).by(1)
      end

      it 'redirects to the options list' do
        post :create, params: { option: valid_attributes }
        expect(response).to redirect_to(options_path)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e., to display the 'new' template)" do
        post :create, params: { option: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end
