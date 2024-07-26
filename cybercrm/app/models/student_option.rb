# frozen_string_literal: true

# student option model
class StudentOption < ApplicationRecord
  audited

  belongs_to :student
  belongs_to :option

  validates :value, presence: true
end
