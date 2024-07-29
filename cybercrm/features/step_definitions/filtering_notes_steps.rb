# frozen_string_literal: true

Given('the following notes exist for sorting tests:') do |table|
  table.hashes.each do |note|
    student = Student.find_by(name: note.delete('student_name'))
    note[:status] ||= 'Active'
    student.notes.create!(note)
  end
end

Given('the following notes exist for filtering tests:') do |table|
  table.hashes.each do |note|
    student = Student.find_by(name: note.delete('student_name'))
    note[:status] ||= 'Active'
    student.notes.create!(note)
  end
end

When('I select {string} from {string} in the notes filter') do |value, filter|
  within('#notes-filter-form') do
    select(value, from: filter)
  end
end

When('I press {string} in the notes filter') do |button|
  within('#notes-filter-form') do
    click_on(button)
  end
end

When('I input {string} with {string} in the notes filter') do |field, value|
  within('#notes-filter-form') do
    fill_in(field, with: value)
  end
end

Then('I should see {string} in the notes table') do |note_content|
  within('#notes-table') do
    expect(page).to have_content(note_content)
  end
end

Then('I should not see {string} in the notes table') do |note_content|
  within('#notes-table') do
    expect(page).to have_no_content(note_content)
  end
end

Given('I am on the notes page for {string}') do |student_name|
  student = Student.find_by(name: student_name)
  visit "/notes/#{student.id}"
end

When('I click the {string} column header in notes table') do |column_name|
  within('#notes-table') do
    click_on column_name
  end
end

Then('I should see notes sorted by {string} in ascending order in notes table') do |column_name|
  sorted_notes = Note.order(column_name.parameterize.underscore.to_sym)
  sorted_notes.each_with_index do |note, index|
    within("#notes-table tbody tr:nth-child(#{index + 1})") do
      expect(page).to have_content(note[column_name.parameterize.underscore.to_sym])
    end
  end
end

Then('I should see notes sorted by {string} in descending order in notes table') do |column_name|
  sorted_notes = Note.order(column_name.parameterize.underscore.to_sym => :desc)
  sorted_notes.each_with_index do |note, index|
    within("#notes-table tbody tr:nth-child(#{index + 1})") do
      expect(page).to have_content(note[column_name.parameterize.underscore.to_sym])
    end
  end
end

Then('I should see notes sorted by {string} in the default order in notes table') do |column_name|
  Note.all.each_with_index do |note, index|
    within("#notes-table tbody tr:nth-child(#{index + 1})") do
      expect(page). to have_content(note[column_name.parameterize.underscore.to_sym])
    end
  end
end
