# frozen_string_literal: true

# app/models/option.rb
class Option < ApplicationRecord
  has_many :student_options, dependent: :destroy
  has_many :students, through: :student_options

  validates :field, presence: true, uniqueness: true
  validates :display_type, presence: true

  # If options are provided, ensure they are valid
  validate :validate_options

  private

  def validate_options
    return unless display_type == 'dropdown' && options.blank?

    errors.add(:options, "can't be blank for dropdown display type")
  end
end
