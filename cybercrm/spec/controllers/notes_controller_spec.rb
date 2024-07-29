# spec/controllers/notes_controller_spec.rb
require 'rails_helper'

RSpec.describe NotesController, type: :controller do
  let(:student) { create(:student) }
  let(:note) { create(:note, student: student) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'filters notes by note_created_date' do
      get :index, params: { note_created_date: note.note_created_date }
      expect(assigns(:notes)).to include(note)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: student.id }
      expect(response).to be_successful
    end

    it 'filters notes by note_created_date' do
      get :show, params: { id: student.id, note_created_date: note.note_created_date }
      expect(assigns(:notes)).to include(note)
    end
  end

  # Add more tests for other actions if needed
end
