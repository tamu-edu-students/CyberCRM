# frozen_string_literal: true

Given('the following students exist for filtering tests:') do |table|
  table.hashes.each do |student|
    Student.create!(student)
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
