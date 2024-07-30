# frozen_string_literal: true

Given('I am on the new user page') do
  visit new_user_path
end

When('I fill in the user form with valid data') do
  fill_in 'user_email', with: 'newuser@example.com'
  select 'student_worker', from: 'Role'
end

When('I submit the user create form') do
  click_on 'Create User'
end

Then('I should see the user has been created') do
  expect(page).to have_content('User was successfully created')
end

Given('a user exists') do
  @user = FactoryBot.create(:user, email: 'existinguser@example.com')
end

When('I visit the users list page') do
  visit users_path
end

When('I click the user row') do
  user_row = find('tr', text: @user.email)
  onclick_attribute = user_row['onclick']
  path = onclick_attribute.match(/window.location='([^']+)'/)[1]
  visit path
end

When('I click the edit button') do
  click_on 'Edit'
end

When('I click the user delete button') do
  click_on 'Delete'
end

When('I update the user form with valid data') do
  select 'Program Director', from: 'Role'
end

When('I submit the user edit form') do
  click_on 'Update User'
end

Then('I should see the user has been updated') do
  expect(page).to have_content('User was successfully updated')
end

Then('I should see the user has been deleted') do
  expect(page).to have_content('User was successfully destroyed')
end
