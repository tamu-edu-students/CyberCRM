# frozen_string_literal: true

Given('I am on the new custom attribute page') do
  visit new_custom_attribute_path
end

When('I fill in the custom attribute form with valid data') do
  fill_in 'custom_attribute_name', with: 'Test Attribute'
  check 'custom_attribute_active'
end

When('I submit the custom attribute create form') do
  click_on 'Create Custom Attribute'
end

Then('I should see the custom attribute has been created') do
  expect(page).to have_content('Custom attribute was successfully created.')
end

Given('a custom attribute exists') do
  @custom_attribute = FactoryBot.create(:custom_attribute)
end

And('I am on the edit custom attribute page for the existing custom attribute') do
  visit edit_custom_attribute_path(@custom_attribute)
end

When('I update the custom attribute form with valid data') do
  fill_in 'custom_attribute_name', with: 'Updated Attribute'
  uncheck 'custom_attribute_active'
end

When('I submit the custom attribute edit form') do
  click_on 'Update Custom Attribute'
end

Then('I should see the custom attribute has been updated') do
  expect(page).to have_content('Custom attribute was successfully updated.')
end

And('I am on the custom attributes list page') do
  visit custom_attributes_path
end

When('I click the toggle status button for the custom attribute') do
  @previous_status = @custom_attribute.active
  button = find('tr', text: @custom_attribute.name).find('form.button_to button')
  button.click
  @custom_attribute.reload
end

Then('I should see the custom attribute status has been toggled') do
  expect(@custom_attribute.active).to eq(!@previous_status)
end

Given('a student with a custom attribute exists') do
  @student = FactoryBot.create(:student)
  @custom_attribute = FactoryBot.create(:custom_attribute, name: 'Test Attribute')
  @student_custom_attribute = FactoryBot.create(:student_custom_attribute, student: @student,
                                                                           custom_attribute: @custom_attribute,
                                                                           value: 'Test Value')
end

When('I retrieve the custom attribute value') do
  @retrieved_value = @student.custom_attribute_value('Test Attribute')
end

Then('I should see the custom attribute value') do
  expect(@retrieved_value).to eq('Test Value')
end
