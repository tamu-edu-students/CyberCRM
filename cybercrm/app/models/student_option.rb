# frozen_string_literal: true

class StudentOption < ApplicationRecord
  belongs_to :student
  belongs_to :option
end
