# frozen_string_literal: true

# Student
class Student < ApplicationRecord
  validates :uin, :name, presence: true
end
