# frozen_string_literal: true

Given('the following students exist for filtering tests:') do |table|
  table.hashes.each do |student_attributes|
    student_attributes.merge!(
      grade_ryg: 'G',
      gender: 'Male',
      ethnicity: 'Asian',
      nationality: 'American',
      expected_graduation: '2025-05-15',
      university_classification: 'Senior',
      status: 'Active',
      sexual_orientation: 'Heterosexual',
      date_of_birth: '2000-01-01',
      email: "#{student_attributes['name'].parameterize}@example.com"
    )
    Student.create!(student_attributes)
  end
end

When('I select {string} from {string}') do |value, filter|
  select(value, from: filter)
end

When('I press {string}') do |button|
  click_on(button)
end

Then('I should not see {string}') do |student_name|
  expect(page).to have_no_content(student_name)
end

When('I input {string} with {string}') do |field, value|
  fill_in(field, with: value)
end
