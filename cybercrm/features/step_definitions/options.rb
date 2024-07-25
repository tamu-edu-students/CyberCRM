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

# rubocop:disable Capybara/VisibilityMatcher
When('I wait for the options input to be visible') do
  expect(page).to have_css('#options-input', visible: true)
end
# rubocop:enable Capybara/VisibilityMatcher

Then('I should see {string} in the options list') do |option|
  within('tbody') do
    expect(page).to have_content(option)
  end
end
