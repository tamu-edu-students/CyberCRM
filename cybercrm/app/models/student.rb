# frozen_string_literal: true

# Student
class Student < ApplicationRecord
  UNIVERSITY_CLASSIFICATIONS = %w[Freshman Sophomore Junior Senior Graduate].freeze
  NATIONALITY_OPTIONS = %w[American British Canadian Australian French German Japanese Chinese
                           Indian Other].freeze
  ETHNICITY_OPTIONS = ['Asian', 'Black', 'Hispanic/Latino', 'Native American', 'White', 'Other'].freeze
  GRADE_OPTIONS = %w[G Y R].freeze
  GENDER_OPTIONS = %w[Male Female].freeze
  SEXUAL_ORIENTATION_OPTIONS = %w[Heterosexual Homosexual].freeze
  STATUS_OPTIONS = %w[Active Inactive].freeze

  validates :name, presence: true, length: { maximum: 200 }
  validates :uin, presence: true, numericality: { only_integer: true }, length: { is: 9 }
  validates :grade_ryg, inclusion: { in: GRADE_OPTIONS }
  validates :gender, presence: true, inclusion: { in: GENDER_OPTIONS }
  validates :ethnicity, presence: true, inclusion: { in: ETHNICITY_OPTIONS }
  validates :nationality, presence: true, inclusion: { in: NATIONALITY_OPTIONS }
  validates :expected_graduation, presence: true, format: { with: /\A\d{4}-\d{2}-\d{2}\z/ }
  validate lambda {
             if expected_graduation.present? && expected_graduation <= Time.zone.today
               errors.add(:expected_graduation, 'must be in the future')
             end
           }
  validates :university_classification, presence: true, inclusion: { in: UNIVERSITY_CLASSIFICATIONS }
  validates :status, presence: true, inclusion: { in: STATUS_OPTIONS }
  validates :sexual_orientation, presence: true, inclusion: { in: SEXUAL_ORIENTATION_OPTIONS }
  validates :date_of_birth, presence: true, format: { with: /\A\d{4}-\d{2}-\d{2}\z/ }
  validate lambda {
             if date_of_birth.present? && date_of_birth > 10.years.ago.to_date
               errors.add(:date_of_birth, 'must be at least 10 years ago')
             end
           }
  validates :email, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }
end
