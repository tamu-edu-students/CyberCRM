# frozen_string_literal: true

# app/models/custom_attribute.rb
class CustomAttribute < ApplicationRecord
  has_many :student_custom_attributes, dependent: :destroy
  has_many :students, through: :student_custom_attributes

  validates :name, presence: true, uniqueness: true
  validates :active, inclusion: { in: [true, false] }
end
