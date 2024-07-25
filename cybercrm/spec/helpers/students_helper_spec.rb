require 'rails_helper'

RSpec.describe StudentsHelper, type: :helper do
  let(:student) { create(:student) }
  let(:option) { create(:option, field: 'gender') }
  let(:student_option) { create(:student_option, student:, option:, value: 'Male') }

  describe '#form_fields' do
    it 'returns a hash of form fields with their types and options' do
      fields = helper.form_fields
      expect(fields).to be_a(Hash)
      expect(fields[:name]).to eq({ type: :text })
      expect(fields[:grade_ryg]).to eq({ type: :select, options: Student::GRADE_OPTIONS })
    end
  end

  describe '#render_field' do
    let(:form) { double('form') }

    before do
      allow(form).to receive(:label).and_return('<label for="name">Name:</label>'.html_safe)
      allow(form).to receive(:text_field).and_return('<input type="text" id="name" class="rounded-lg">'.html_safe)
      allow(form).to receive(:select).and_return('<select id="gender" class="rounded-lg"><option value="All">All</option></select>'.html_safe)
      allow(form).to receive(:date_field).and_return('<input type="date" id="expected_graduation" class="rounded-lg">'.html_safe)
    end

    it 'renders a text field' do
      output = helper.render_field(form, :name, { type: :text })
      expect(output).to eq('<div><label for="name">Name:</label><input type="text" id="name" class="rounded-lg"></div>')
    end

    it 'renders a select field' do
      output = helper.render_field(form, :gender, { type: :select, options: [] })
      expect(output).to eq('<div><label for="gender">Gender:</label><select id="gender" class="rounded-lg"><option value="All">All</option></select></div>')
    end

    it 'renders a date field' do
      output = helper.render_field(form, :expected_graduation, { type: :date })
      expect(output).to eq('<div><label for="expected_graduation">Expected Graduation:</label><input type="date" id="expected_graduation" class="rounded-lg"></div>')
    end
  end

  describe '#custom_attribute_value' do
    it 'returns the value of the custom attribute for the student' do
      student_option # Ensure the student_option is created
      value = helper.custom_attribute_value(student, 'gender')
      expect(value).to eq('Male')
    end

    it 'returns nil if the option is not found' do
      value = helper.custom_attribute_value(student, 'non_existent_field')
      expect(value).to be_nil
    end
  end

  describe '#custom_value' do
    it 'returns the custom value for the student' do
      student_option # Ensure the student_option is created
      value = helper.custom_value(student, 'gender')
      expect(value).to eq('Male')
    end

    it 'returns an empty string if the custom value is not found' do
      value = helper.custom_value(student, 'non_existent_field')
      expect(value).to eq('')
    end
  end
end
