# frozen_string_literal: true

Given('I am on the new student page') do
  visit new_student_path
end

When('I fill in the student form with valid data') do
  fill_in 'Name', with: 'John Doe'
  fill_in 'Uin', with: '123456789'
  fill_in 'Gender', with: 'Male'
  fill_in 'Ethnicity', with: 'Asian'
  fill_in 'Nationality', with: 'American'
  fill_in 'Expected graduation', with: '2025-05-01'
  fill_in 'University classification', with: 'Senior'
  fill_in 'Status', with: '1'
  fill_in 'Sexual orientation', with: '1'
  fill_in 'Date of birth', with: '2000-01-01'
  fill_in 'Email', with: 'jdoe@tamu.edu'
end

When('I submit the create form') do
  click_button 'Create Student'
end

When('I submit the edit form') do
  click_button 'Update Student'
end

Then('I should see the student has been created') do
  expect(page).to have_content 'Student was successfully created'
  expect(Student.count).to eq 1
end

Given('a student exists') do
  @student = Student.create(
    name: 'Jane Doe',
    uin: '987654321',
    gender: 'Female',
    ethnicity: 'Caucasian',
    nationality: 'Canadian',
    expected_graduation: '2024-05-01',
    university_classification: 'Junior',
    status: '1',
    sexual_orientation: '1',
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
  click_button 'Delete this student'
end

Then('I should see the student has been deleted') do
  expect(page).to have_content 'Student was successfully deleted'
  expect(Student.count).to eq 0
end

Given('I am on the students index page') do
  visit students_path
end

When('I click the New Student button') do
  click_link 'New student'
end

Then('I should be on the new student page') do
  expect(page).to have_current_path(new_student_path)
end