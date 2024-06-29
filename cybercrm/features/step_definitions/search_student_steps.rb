# frozen_string_literal: true

# features/step_definitions/student_steps.rb
Given('the following students exist:') do |table|
  table.hashes.each do |student|
    Student.create!(student)
  end
end

When('I go to the students page') do
  visit pages_students_path
end

When('I fill in {string} with {string}') do |field, value|
  fill_in field, with: value
end

When('I press {string}') do |button|
  click_button button
end

Then('I should see {string}') do |content|
  expect(page).to have_content(content)
end

Then('I should not see {string}') do |content|
  expect(page).to have_no_content(content)
end

Then('I should not see {string} with {string} less than or equal to {int}') do |name, value|
  within('table') do
    page.all('tr').find_each do |tr|
      if tr.has_content?(name)
        certifications = tr.find('td', text: /Certifications/).text.to_i
        expect(certifications).to be > value if certifications <= value
      end
    end
  end
end
