# frozen_string_literal: true

require 'rails_helper'
require 'csv'

# rubocop:disable RSpec/MultipleExpectations
# rubocop:disable FactoryBot/ExcessiveCreateList
RSpec.describe StudentsController do
  describe 'GET #search' do
    let(:johndoe) { create(:student, name: 'John Doe') }
    let(:janesmith) { create(:student, name: 'Jane Smith') }
    let(:johnnyappleseed) { create(:student, name: 'Johnny Appleseed') }

    context 'when student_search param is present' do
      it 'returns matching students' do
        get :search, params: { student_search: 'John' }, format: :turbo_stream

        expect(assigns(:students)).to contain_exactly(johndoe, johnnyappleseed)
      end

      it 'limits the number of returned students to 10' do
        create_list(:student, 11, name: 'John Doe')

        get :search, params: { student_search: 'John' }, format: :turbo_stream

        expect(assigns(:students).count).to eq(10)
      end
    end

    context 'when student_search param is not present' do
      it 'returns an empty array' do
        get :search, format: :turbo_stream

        expect(assigns(:students)).to be_empty
      end
    end

    context 'when response format' do
      it 'renders the search_results partial with turbo_stream format' do
        get :search, params: { student_search: 'John' }, format: :turbo_stream

        expect(response.media_type).to eq Mime[:turbo_stream]
        expect(response).to render_template(partial: 'students/_search_results')
      end
    end
  end

  describe 'POST #update_custom_attribute' do
    let!(:student) { create(:student) }
    let!(:custom_attribute) { create(:custom_attribute) }
    let(:valid_params) do
      {
        id: student.id,
        attribute_id: custom_attribute.id,
        value: 'New Value'
      }
    end
    let(:invalid_params) do
      {
        id: student.id,
        attribute_id: custom_attribute.id,
        value: ''
      }
    end

    context 'with valid parameters' do
      it 'updates the custom attribute and redirects to the student' do
        post :update_custom_attribute, params: valid_params

        expect(response).to redirect_to(student)
        expect(flash[:notice]).to eq(I18n.t('attr_updated'))
        expect(student.student_custom_attributes.find_by(custom_attribute:).value).to eq('New Value')
      end
    end

    context 'with invalid parameters' do
      it 'renders the show template' do
        post :update_custom_attribute, params: invalid_params

        expect(response).to render_template(:show)
      end
    end
  end

  describe 'POST #process_csv_file' do
    context 'with valid CSV data' do
      let(:csv_data) do
        <<~CSV
          name,uin,grade_ryg,gender,ethnicity,nationality,expected_graduation,university_classification,status,sexual_orientation,date_of_birth,email
          John Doe,123456789,G,Male,Asian,American,2025-05-15,Senior,Active,Heterosexual,2000-01-01,john.doe@example.com
          Jane Smith,987654321,Y,Female,White,American,2024-12-20,Junior,Active,Heterosexual,2001-02-14,jane.smith@example.com
        CSV
      end

      let(:file) { Tempfile.new(['students', '.csv']) }

      before do
        file.write(csv_data)
        file.rewind
        allow(controller).to receive(:process_csv_file).and_call_original
        post :import, params: { file: fixture_file_upload(file.path, 'text/csv') }
      end

      it 'processes the CSV file and redirects to students_url with a notice' do
        expect(response).to redirect_to(students_url)
        expect(flash[:notice]).to eq(I18n.t('student_imported'))
        expect(Student.count).to eq(2)
      end
    end

    context 'with invalid CSV data' do
      let(:csv_data) do
        <<~CSV
          name,uin,grade_ryg,gender,ethnicity,nationality,expected_graduation,university_classification,status,sexual_orientation,date_of_birth,email
          John Doe,123456789,G,Male,Asian,American,2025-05-15,Senior,Active,Heterosexual,2000-01-01
          Jane Smith,987654321,Y,Female,White,American,2024-12-20,Junior,Active,Heterosexual,2001-02-14
        CSV
      end

      let(:file) { Tempfile.new(['students', '.csv']) }

      before do
        file.write(csv_data)
        file.rewind
        allow(controller).to receive(:process_csv_file).and_call_original
        post :import, params: { file: fixture_file_upload(file.path, 'text/csv') }
      end

      it 'processes the CSV file and redirects to students_url with an alert' do
        expect(response).to redirect_to(students_url)
        expect(flash[:alert]).to include('Error saving students:')
        expect(Student.count).to eq(0)
      end
    end
  end
end
# rubocop:enable RSpec/MultipleExpectations
# rubocop:enable FactoryBot/ExcessiveCreateList
