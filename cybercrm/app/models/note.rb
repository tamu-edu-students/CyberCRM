# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :student

  validates :note_created_date, presence: true
  validates :note, presence: true
  validates :status, presence: true, inclusion: { in: %w[Active Inactive] }
end
