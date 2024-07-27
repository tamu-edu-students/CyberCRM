# frozen_string_literal: true

Given('the following notes exist for filtering tests:') do |table|
  table.hashes.each do |note|
    student = Student.find_by(name: note.delete('student_name'))
    student.notes.create!(note)
  end
end
