# features/step_definitions/search_student_steps.rb
Given('the following students exist:') do |table|
  table.hashes.each do |student|
    Student.create!(student)
  end
end

When('I go to the students page') do
  visit pages_login_path
end

When('I click on the search icon') do
  find('#search-link').click
end

When('I fill in the search field with {string}') do |value|
  fill_in 'text-entry', with: value
end

When('I press the search button') do
  # Assuming the form is submitted automatically on input
end

Then('I should see {string} in the search results') do |content|
  all("turbo-frame#modal").any? do |frame|
    within(frame) do
      has_content?(content)
    end
  end
end

Then('I should not see {string} in the search results') do |content|
  all("turbo-frame#modal").any? do |frame|
    within(frame) do
      has_no_content?(content)
    end
  end
end
