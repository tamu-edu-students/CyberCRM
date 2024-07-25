# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'GET #login' do
    it 'returns a successful response' do
      get :login
      expect(response).to be_successful
    end
  end

  describe 'GET #home' do
    let(:valid_attributes) { { attribute: 'gender', chart_type: 'bar' } }

    before do
      # Create some test data for Student
      create_list(:student, 3, gender: 'Male')
      create_list(:student, 2, gender: 'Female')
    end

    it 'returns a successful response' do
      get :home, params: valid_attributes
      expect(response).to be_successful
    end

    it 'assigns the correct attributes' do
      get :home, params: valid_attributes
      expect(assigns(:attribute)).to eq('gender')
      expect(assigns(:chart_type)).to eq('bar')
    end

    it 'fetches correct chart data' do
      get :home, params: valid_attributes
      expect(assigns(:chart_data)).to eq(Student.group(:gender).count)
    end

    it 'assigns available chart types' do
      get :home
      expect(assigns(:chart_types)).to eq(%w[bar line pie column])
    end

    it 'assigns available attributes' do
      get :home
      expect(assigns(:attributes)).to eq(%w[gender ethnicity nationality university_classification status sexual_orientation grade_ryg])
    end
  end
end
