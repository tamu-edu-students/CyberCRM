# frozen_string_literal: true

When('I visit the home page') do
  visit pages_home_path
end

And('I click the sign out button') do
  click_on 'Sign out', match: :first
end

Then('I should be redirected to the root page') do
  expect(page).to have_current_path(root_path)
end

Then('I should see a sign-out notice') do
  expect(page).to have_content(I18n.t('signed_out'))
end

Then('I should not be logged in') do
  user_id = begin
    page.get_rack_session_key('user_id')
  rescue StandardError
    nil
  end
  expect(user_id).to be_nil
end
