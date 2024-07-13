# frozen_string_literal: true

Given('I am logged in as a super user') do
  login_with_google_oauth2
  @test_user = test_user(role: 'super_user')
  page.set_rack_session(user_id: @test_user.id)
end

Given('I am logged in as a non-super user') do
  login_with_google_oauth2
  @test_user = test_user(role: 'program_director')
  page.set_rack_session(user_id: @test_user.id)
end

When('I visit the edit user page') do
  visit edit_user_path(@user)
end

Then('I should see the edit user page again') do
  expect(page).to have_current_path(edit_user_path(@user))
end

Then('I should see an error message') do
  expect(page).to have_content('prohibited this user from being saved')
end

Then('I should see an unauthorized alert') do
  expect(page).to have_current_path(root_path)
  expect(page).to have_content(I18n.t('unauthorized'))
end
