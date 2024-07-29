# frozen_string_literal: true

# Note belongs to student
class Note < ApplicationRecord
  audited

  belongs_to :student

  validates :note_created_date, presence: true
  validates :note, presence: true
  validates :status, presence: true, inclusion: { in: %w[Active Inactive] }
end
