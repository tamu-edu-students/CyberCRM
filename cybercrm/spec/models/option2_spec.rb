# frozen_string_literal: true

require 'rails_helper'
RSpec.describe OptionsController, type: :controller do
  let(:valid_attributes) {
    { field: 'Gender', display_type: 'dropdown', options: 'Male,Female' }
  }

  let(:invalid_attributes) {
    { field: nil, display_type: nil, options: nil }
  }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Option" do
        expect {
          post :create, params: { option: valid_attributes }
          expect(response.status).to eq(302) # ensure the response status is a redirect
          expect(response).to redirect_to(options_path) # ensure it redirects to the options list
        }.to change(Option, :count).by(1)
      end

      it "redirects to the options list" do
        post :create, params: { option: valid_attributes }
        expect(response).to redirect_to(options_path)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e., to display the 'new' template)" do
        post :create, params: { option: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end
