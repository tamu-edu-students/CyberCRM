# frozen_string_literal: true

# Student
class Student < ApplicationRecord
  has_many :student_programs
  has_many :programs, through: :student_programs

  # Constants
  UNIVERSITY_CLASSIFICATIONS = %w[Freshman Sophomore Junior Senior Graduate].freeze
  NATIONALITY_OPTIONS = %w[American British Canadian Australian French German Japanese Chinese
                           Indian Other].freeze
  ETHNICITY_OPTIONS = ['Asian', 'Black', 'Hispanic/Latino', 'Native American', 'White', 'Other'].freeze
  GRADE_OPTIONS = %w[G Y R].freeze
  GENDER_OPTIONS = %w[Male Female].freeze
  SEXUAL_ORIENTATION_OPTIONS = %w[Heterosexual Homosexual].freeze
  STATUS_OPTIONS = %w[Active Inactive].freeze

  # Validation
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
  # Filter
  scope :by_name, ->(name) { where('name ILIKE ?', "%#{name}%") if name.present? }
  scope :by_uin, ->(uin) { where(uin:) if uin.present? }
  scope :by_grade, ->(grade) { where(grade_ryg: grade) if grade.present? }
  scope :by_gender, ->(gender) { where(gender:) if gender.present? }
  scope :by_ethnicity, ->(ethnicity) { where(ethnicity:) if ethnicity.present? }
  scope :by_nationality, ->(nationality) { where(nationality:) if nationality.present? }
  scope :by_expected_graduation, ->(date) { where(expected_graduation: date) if date.present? }
  scope :by_university_classification, lambda { |classification|
                                         where(university_classification: classification) if classification.present?
                                       }
  scope :by_status, ->(status) { where(status:) if status.present? }
  scope :by_sexual_orientation, ->(orientation) { where(sexual_orientation: orientation) if orientation.present? }
  scope :by_date_of_birth, ->(dob) { where(date_of_birth: dob) if dob.present? }
  scope :by_email, ->(email) { where('email ILIKE ?', "%#{email}%") if email.present? }
end
