# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'students/edit' do
  let(:student) do
    Student.create!(
      name: 'MyString',
      age: 1,
      grade: 'MyString',
      uin: 1,
      gpa: '9.99',
      gender: 'MyString',
      ethnicity: 'MyString',
      nationality: 'MyString',
      university_classification: 'MyString'
    )
  end

  before do
    assign(:student, student)
  end

  it 'renders the edit student form' do
    render

    assert_select 'form[action=?][method=?]', student_path(student), 'post' do
      assert_select 'input[name=?]', 'student[name]'

      assert_select 'input[name=?]', 'student[age]'

      assert_select 'input[name=?]', 'student[grade]'

      assert_select 'input[name=?]', 'student[uin]'

      assert_select 'input[name=?]', 'student[gpa]'

      assert_select 'input[name=?]', 'student[gender]'

      assert_select 'input[name=?]', 'student[ethnicity]'

      assert_select 'input[name=?]', 'student[nationality]'

      assert_select 'input[name=?]', 'student[university_classification]'
    end
  end
end
