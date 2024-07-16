# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'notes/show' do
  before do
    student = Student.new(name: "test_name", uin: "123456789", gpa: 3.9, gender: "Male", ethnicity: "Other", nationality: "American", expected_graduation: Date.new(2024,12,12), university_classification:"Junior", status: "Active", sexual_orientation: "Heterosexual", date_of_birth: Date.new(1995,4,14), grade_ryg: 'G', email: "temail@tamu.edu"  )
    student.notes.build(note: "test note", note_created_date: Date.new(2024, 5, 14),
                      followup_action: "test follow up note", followup_date: Date.new(2024, 5, 21), action_completed: true, status: 'Active')
    student.save!
    notes = student.notes
    note = notes.first
    assign(:note, note)
  end

  # it 'renders attributes in <p>' do
  #   render
  # end
end
