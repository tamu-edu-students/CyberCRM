# frozen_string_literal: true

When('I click the {string} column header') do |column_name|
  click_link column_name
end

Then('I should see students sorted by {string} in ascending order') do |column_name|
  Student.order(column_name.parameterize.underscore.to_sym)
  expect(find('th', text: column_name)).to have_content("↑")
end

Then('I should see students sorted by {string} in descending order') do |column_name|
  Student.order(column_name.parameterize.underscore.to_sym => :desc)
  expect(find('th', text: column_name)).to have_content("↓")
end

Then('I should see students sorted by {string} in the default order') do |column_name|
  Student.all
  expect(find('th', text: column_name)).to_not have_content("↑")
  expect(find('th', text: column_name)).to_not have_content("↓")
end
