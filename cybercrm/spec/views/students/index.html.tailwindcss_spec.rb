# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'students/index' do
  before do
    assign(:students, [
             Student.create!(
               name: 'Name',
               age: 2,
               grade: 'Grade',
               uin: 3,
               gpa: '9.99',
               gender: 'Gender',
               ethnicity: 'Ethnicity',
               nationality: 'Nationality',
               university_classification: 'University Classification'
             ),
             Student.create!(
               name: 'Name',
               age: 2,
               grade: 'Grade',
               uin: 3,
               gpa: '9.99',
               gender: 'Gender',
               ethnicity: 'Ethnicity',
               nationality: 'Nationality',
               university_classification: 'University Classification'
             )
           ])
  end

  it 'renders a list of students' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Name'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Grade'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('9.99'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Gender'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Ethnicity'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Nationality'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('University Classification'.to_s), count: 2
  end
end
