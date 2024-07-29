# frozen_string_literal: true

Given('the following notes exist for sorting tests:') do |table|
  table.hashes.each do |note|
    student = Student.find_by(name: note.delete('student_name'))
    note[:status] ||= 'Active'
    student.notes.create!(note)
  end
end

When('I click the {string} column header in notes table') do |column_name|
  click_on column_name
end


Then('I should see notes sorted by {string} in ascending order in notes table') do |column_name|
  Note.order(column_name.parameterize.underscore.to_sym)
  expect(find('th', text: column_name)).to have_content('↑')
end

Then('I should see notes sorted by {string} in descending order in notes table') do |column_name|
  Note.order(column_name.parameterize.underscore.to_sym => :desc)
  expect(find('th', text: column_name)).to have_content('↓')
end

Then('I should see notes sorted by {string} in the default order in notes table') do |column_name|
  Note.all
  expect(find('th', text: column_name)).to have_no_content('↑')
  expect(find('th', text: column_name)).to have_no_content('↓')
end
