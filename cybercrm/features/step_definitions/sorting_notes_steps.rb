# frozen_string_literal: true

When('I click the {string} column header') do |column_name|
  click_on column_name
end

Then('I should see notes sorted by {string} in ascending order') do |column_name|
  sorted_notes = Note.order(column_name.parameterize.underscore.to_sym).pluck(column_name.parameterize.underscore.to_sym)
  sorted_notes.each_with_index do |note_content, index|
    expect(page.all('tbody tr')[index]).to have_content(note_content)
  end
end

Then('I should see notes sorted by {string} in descending order') do |column_name|
  sorted_notes = Note.order(column_name.parameterize.underscore.to_sym => :desc).pluck(column_name.parameterize.underscore.to_sym)
  sorted_notes.each_with_index do |note_content, index|
    expect(page.all('tbody tr')[index]).to have_content(note_content)
  end
end

Then('I should see notes sorted by {string} in the default order') do |column_name|
  default_notes = Note.all.pluck(column_name.parameterize.underscore.to_sym)
  default_notes.each_with_index do |note_content, index|
    expect(page.all('tbody tr')[index]).to have_content(note_content)
  end
end

Given('I am on the notes page for {string}') do |student_name|
  student = Student.find_by(name: student_name)
  visit student_notes_path(student)
end

Given('the following notes exist for sorting tests:') do |table|
  table.hashes.each do |note_attributes|
    student = Student.find_by(name: note_attributes.delete('student_name'))
    student.notes.create!(note_attributes)
  end
end
