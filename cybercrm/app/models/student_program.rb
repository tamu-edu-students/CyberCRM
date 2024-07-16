# frozen_string_literal: true

class StudentProgram < ApplicationRecord
  belongs_to :student
  belongs_to :program

  validates :student_id, uniqueness: { scope: :program_id }
end
