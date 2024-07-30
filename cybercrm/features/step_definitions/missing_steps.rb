# frozen_string_literal: true

When('I select {string} from {string} in the students filter') do |option, filter|
  select option, from: filter
end

When('I press {string} in the students filter') do |button|
  click_on button
end

Then('I should see {string} in the students table') do |content|
  all('turbo-frame#modal').any? do |frame|
    within(frame) do
      has_content?(content)
    end
  end
end

Then('I should not see {string} in the students table') do |content|
  all('turbo-frame#modal').any? do |frame|
    within(frame) do
      has_no_content?(content)
    end
  end
end

When('I input {string} with {string} in the students filter') do |field, value|
  fill_in field, with: value
end

Given('the following students exist for sorting tests:') do |table|
  table.hashes.each do |student|
    Student.create!(student)
  end
end
