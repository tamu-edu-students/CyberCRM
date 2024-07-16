# frozen_string_literal: true

class Program < ApplicationRecord
  has_many :student_programs
  has_many :students, through: :student_programs

  validates :name, presence: true, uniqueness: true
end
