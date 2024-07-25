# frozen_string_literal: true

# Student Option
class StudentOption < ApplicationRecord
  belongs_to :student
  belongs_to :option
end
