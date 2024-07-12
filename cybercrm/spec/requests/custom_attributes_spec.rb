# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CustomAttributes' do
  describe 'GET /index' do
    it 'returns http success' do
      get '/custom_attributes/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/custom_attributes/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/custom_attributes/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get '/custom_attributes/edit'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /update' do
    it 'returns http success' do
      get '/custom_attributes/update'
      expect(response).to have_http_status(:success)
    end
  end
end
