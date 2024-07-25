class StudentOption < ApplicationRecord
  belongs_to :student
  belongs_to :option

  validates :option, presence: true
  validates :value, presence: true
end
