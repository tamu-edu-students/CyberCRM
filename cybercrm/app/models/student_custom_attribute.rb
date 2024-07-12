# frozen_string_literal: true

# stduent custom attributes
class StudentCustomAttribute < ApplicationRecord
  belongs_to :student
  belongs_to :custom_attribute

  validates :value, presence: true
end
