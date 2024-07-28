# frozen_string_literal: true

Given('the following notes exist for filtering tests:') do |table|
  table.hashes.each do |note|
    student = Student.find_by(name: note.delete('student_name'))
    student.notes.create!(note)
  end
end

When('I filter notes by selecting {string} from {string}') do |value, filter|
  within('#notes-filter-form') do
    select(value, from: filter)
  end
end

When('I filter notes by pressing {string}') do |button|
  within('#notes-filter-form') do
    click_on(button)
  end
end

When('I filter notes by inputting {string} with {string}') do |field, value|
  within('#notes-filter-form') do
    fill_in(field, with: value)
  end
end

Then('I should see the note with content {string}') do |note_content|
  within('#notes-table') do
    expect(page).to have_content(note_content)
  end
end

Then('I should not see the note with content {string}') do |note_content|
  within('#notes-table') do
    expect(page).to have_no_content(note_content)
  end
end
