# frozen_string_literal: true

Given('the following notes exist for sorting tests:') do |table|
  table.hashes.each do |note|
    student = Student.find_by(name: note.delete('student_name'))
    note[:status] ||= 'Active'
    student.notes.create!(note)
  end
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
      expect(page).to have_content(note[column_name.parameterize.underscore.to_sym])
    end
  end
end
