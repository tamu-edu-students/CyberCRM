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
  expect(page).not_to have_content(student_name)
end

When('I search within the div {string} for the dropdown {string}') do |div_id, dropdown_id|
  @dropdown = find("##{div_id}").find("##{dropdown_id}")
end

When('I select {string} from the dropdown') do |option|
  @dropdown.select(option)
end

Then('I should see {string} is selected') do |option|
  expect(@dropdown.value).to eq(option)
end
