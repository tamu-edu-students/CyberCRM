# frozen_string_literal: true

# spec/controllers/options_controller_spec.rb
require 'rails_helper'

RSpec.describe OptionsController do
  let(:valid_attributes) do
    { field: 'Gender', display_type: 'dropdown', options: 'Non-binary' }
  end

  let(:invalid_attributes) do
    { field: 'Gender', display_type: '', options: '' }
  end

  let(:existing_option) do
    create(:option, field: 'Gender', display_type: 'dropdown', options: 'Male, Female')
  end

  describe 'POST #create' do
    context 'with valid params and existing option' do
      before do
        existing_option
      end

      it 'updates the existing option with new options' do
        post :create, params: { option: valid_attributes }
        existing_option.reload
        expect(existing_option.options).to include('Male', 'Female', 'Non-binary')
        expect(response).to redirect_to(options_path)
        expect(flash[:notice]).to eq('Option was successfully updated.')
      end

      it 'renders the new template with errors if update fails' do
        allow_any_instance_of(Option).to receive(:update).and_return(false)
        post :create, params: { option: valid_attributes }
        expect(assigns(:option)).to eq(existing_option)
        expect(response).to render_template(:new)
      end
    end

    context 'with valid params and new option' do
      it 'creates a new Option' do
        expect do
          post :create, params: { option: { field: 'New Field', new_field: 'Age', display_type: 'dropdown',
                                            options: '18-25' } }
        end.to change(Option, :count).by(1)
        expect(response).to redirect_to(options_path)
        expect(flash[:notice]).to eq('Option was successfully created.')
      end
    end

    context 'with invalid params' do
      it 'renders the new template with errors' do
        post :create, params: { option: invalid_attributes }
        expect(assigns(:option)).to be_a_new(Option)
        expect(response).to render_template(:new)
      end
    end
  end
end
