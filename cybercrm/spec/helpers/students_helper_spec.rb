require 'rails_helper'

RSpec.describe StudentsHelper, type: :helper do
  let(:student) { create(:student) }
  let(:option) { create(:option, field: 'gender', display_type: 'select', options: 'Male, Female, Non-binary') }
  let(:student_option) { create(:student_option, student: student, option: option, value: 'Male') }

  before do
    # Ensure options are loaded before each test
    student.load_dynamic_options
  end

  describe '#form_fields' do
    it 'returns a hash of form fields with their types and options' do
      fields = helper.form_fields(student)
      expect(fields).to be_a(Hash)
      expect(fields[:name]).to eq({ type: :text })
      expect(fields[:grade_ryg]).to eq({ type: :select, options: %w[G Y R] })
      expect(fields[:gender]).to eq({ type: :select, options: student.dynamic_genders })
      expect(fields[:ethnicity]).to eq({ type: :select, options: student.dynamic_ethnicities })
      expect(fields[:nationality]).to eq({ type: :select, options: student.dynamic_nationalities })
      expect(fields[:expected_graduation]).to eq({ type: :date })
      expect(fields[:university_classification]).to eq({ type: :select, options: student.dynamic_classifications })
      expect(fields[:status]).to eq({ type: :select, options: student.dynamic_statuses })
      expect(fields[:sexual_orientation]).to eq({ type: :select, options: student.dynamic_orientations })
      expect(fields[:date_of_birth]).to eq({ type: :date })
      expect(fields[:email]).to eq({ type: :text })
    end
  end

  describe '#render_field' do
    let(:form) { double('form') }

    before do
      allow(form).to receive(:label).with(:name, "Name:").and_return('<label for="name">Name:</label>'.html_safe)
      allow(form).to receive(:label).with(:gender, "Gender:").and_return('<label for="gender">Gender:</label>'.html_safe)
      allow(form).to receive(:label).with(:expected_graduation, "Expected Graduation:").and_return('<label for="expected_graduation">Expected Graduation:</label>'.html_safe)
      allow(form).to receive(:text_field).with(:name, class: 'rounded-lg').and_return('<input type="text" id="name" class="rounded-lg">'.html_safe)
      allow(form).to receive(:select).with(:gender, ['All'] + student.dynamic_genders, include_blank: true, class: 'rounded-lg').and_return('<select id="gender" class="rounded-lg"><option value="All">All</option><option value="Male">Male</option><option value="Female">Female</option><option value="Non-binary">Non-binary</option></select>'.html_safe)
      allow(form).to receive(:date_field).with(:expected_graduation, class: 'rounded-lg').and_return('<input type="date" id="expected_graduation" class="rounded-lg">'.html_safe)
    end

    it 'renders a text field' do
      output = helper.render_field(form, :name, { type: :text })
      expect(output).to eq('<div><label for="name">Name:</label><input type="text" id="name" class="rounded-lg"></div>')
    end

    it 'renders a select field' do
      output = helper.render_field(form, :gender, { type: :select, options: student.dynamic_genders })
      expect(output).to eq('<div><label for="gender">Gender:</label><select id="gender" class="rounded-lg"><option value="All">All</option><option value="Male">Male</option><option value="Female">Female</option><option value="Non-binary">Non-binary</option></select></div>')
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
end
