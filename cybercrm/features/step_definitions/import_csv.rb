# frozen_string_literal: true

When('I upload a valid CSV file') do
  attach_file('file', Rails.root.join('spec/fixtures/students.csv'))
  click_link_or_button 'Import'
end

Then('I should see {string}') do |message|
  expect(page).to have_content(message)
end

Then('I should see the following students:') do |table|
  table.hashes.each do |student|
    student.each_value do |value|
      expect(page).to have_content(value)
    end
  end
end
