# frozen_string_literal: true

When('I visit the options page') do
  visit options_path
end

Then('I should see a list of options') do
  expect(page).to have_content('Gender')
  expect(page).to have_content('Ethnicity')
  expect(page).to have_content('Nationality')
end

When('I visit the new option page') do
  visit new_option_path
end
