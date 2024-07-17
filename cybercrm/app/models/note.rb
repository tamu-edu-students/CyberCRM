# frozen_string_literal: true

# Note is dependent on student class. Student is the main class the builds and returns notes
class Note < ApplicationRecord
  belongs_to :student

  validates :note_created_date, presence: true
  validates :note, presence: true
  validates :status, presence: true, inclusion: { in: %w[Active Inactive] }
end
