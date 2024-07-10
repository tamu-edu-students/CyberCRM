# frozen_string_literal: true

When('I fill in {string} with {string}') do |field, value|
  fill_in field, with: value
end

When('I leave the {string} field blank') do |field|
  fill_in field, with: ''
end

When('I submit the form') do
  click_link_or_button 'Create Student'
end
