# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'students/new' do
  before do
    assign(:student, Student.new(
                       name: 'MyString',
                       age: 1,
                       grade: 'MyString',
                       uin: 1,
                       gpa: '9.99',
                       gender: 'MyString',
                       ethnicity: 'MyString',
                       nationality: 'MyString',
                       university_classification: 'MyString'
                     ))
  end

  it 'renders new student form' do
    render

    assert_select 'form[action=?][method=?]', students_path, 'post' do
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
