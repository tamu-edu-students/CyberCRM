Given('I am logged into Google as a Program Director') do
end

Given('the following students exist for filtering tests:') do |table|
  @students = table.hashes
end

When('I select {string} from {string}') do |value, filter|
  select(value, from: filter.downcase)
end

When('I press {string}') do |button|
  click_button(button)
end

Then('I should see {string}') do |student_name|
  expect(page).to have_content(student_name)
end

Then('I should not see {string}') do |student_name|
  expect(page).not_to have_content(student_name)
end
