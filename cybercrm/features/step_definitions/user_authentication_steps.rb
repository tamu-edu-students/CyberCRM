# frozen_string_literal: true

Given('I am on the login page') do
  visit root_path
end

Then('On the login page, I should see {string}') do |text|
  expect(page).to have_content(text)
end

Given('I am logged in as a program director') do
  login_with_google_oauth2
  @test_user1 = test_user1
  page.set_rack_session(user_id: @test_user1.id)
end

Given('I am logged in as a student worker') do
  login_with_google_oauth2
  @test_user2 = test_user2
  page.set_rack_session(user_id: @test_user2.id)
end

When('I log out') do
  click_on 'Log out'
end

Then('I should see that I have been logged out') do
  expect(page).to have_content 'Signed out successfully'
end