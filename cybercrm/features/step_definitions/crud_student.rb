# frozen_string_literal: true

# features/step_definitions/student_steps.rb

Given('I am logged in with Google') do
  login_with_google_oauth2
  @test_user = test_user(role: 'super_user')
  @current_user = test_user(role: 'super_user')
  page.set_rack_session(user_id: @test_user.id)
end

Given('I am logged in with Google as Program Manager') do
  login_with_google_oauth2
  @test_user = test_user(role: 'program_director')
  @current_user = test_user(role: 'program_director')
  page.set_rack_session(user_id: @test_user.id)
end

Given('I am on the new student page') do
  visit new_student_path
end

When('I fill in the student form with valid data') do
  fill_in 'Name', with: 'John Doe'
  fill_in 'UIN', with: '123456789'
  select 'R', from: 'grade_ryg'
  select 'Male', from: 'Gender'
  select 'Asian', from: 'Ethnicity'
  select 'American', from: 'Nationality'
  fill_in 'Expected graduation', with: '2025-05-01'
  select 'Senior', from: 'University classification'
  select 'Active', from: 'Status'
  select 'Heterosexual', from: 'Sexual orientation'
  fill_in 'Date of birth', with: '2000-01-01'
  fill_in 'Email', with: 'jdoe@tamu.edu'
end

When('I submit the create form') do
  click_on 'Create Student'
end

Then('I should see the student has been created') do
  expect(page).to have_content 'Student was successfully created'
  expect(Student.count).to eq 1
end

Given('a student exists') do
  @student = Student.create!(
    name: 'Jane Doe',
    uin: '987654321',
    grade_ryg: 'R',
    gender: 'Female',
    ethnicity: 'White',
    nationality: 'Canadian',
    expected_graduation: '2025-05-01',
    university_classification: 'Junior',
    status: 'Active',
    sexual_orientation: 'Heterosexual',
    date_of_birth: '2001-01-01',
    email: 'jane.doe@example.com'
  )
end

When("I visit the student's page") do
  visit student_path(@student)
end

Then("I should see the student's details") do
  expect(page).to have_content @student.name
  expect(page).to have_content @student.uin
end

When('I visit the edit student page') do
  visit edit_student_path(@student)
end

When('I update the student form with valid data') do
  fill_in 'Name', with: 'Jane Smith'
end

Then('I should see the student has been updated') do
  expect(page).to have_content 'Student was successfully updated'
  expect(@student.reload.name).to eq 'Jane Smith'
end

When('I click the delete button') do
  visit student_path(@student)
  click_on 'Delete this student'
end

When('I submit the edit form') do
  click_on 'Update Student'
end

Then('I should see the student has been deleted') do
  expect(page).to have_content 'Student was successfully deleted'
  expect(Student.count).to eq 0
end

Given('I am on the students index page') do
  visit students_path
end
