# frozen_string_literal: true

# app/models/student.rb
class Student < ApplicationRecord
  audited

  has_many :student_options, dependent: :destroy
  has_many :options, through: :student_options
  has_many :notes, dependent: :destroy

  before_validation :load_dynamic_options

  validates :name, presence: true, length: { minimum: 4, maximum: 200 }
  validates :uin, presence: true, numericality: { only_integer: true }, length: { is: 9 }, uniqueness: true
  validates :grade_ryg, inclusion: { in: %w[G Y R] }
  validates :gender, presence: true, inclusion: { in: ->(student) { student.dynamic_genders } }
  validates :ethnicity, presence: true, inclusion: { in: ->(student) { student.dynamic_ethnicities } }
  validates :nationality, presence: true, inclusion: { in: ->(student) { student.dynamic_nationalities } }
  validates :expected_graduation, presence: true, format: { with: /\A\d{4}-\d{2}-\d{2}\z/ }
  validate :expected_graduation_must_be_in_the_future
  validates :university_classification, presence: true, inclusion: { in: ->(student) { student.dynamic_classifications } }
  validates :status, presence: true, inclusion: { in: ->(student) { student.dynamic_statuses } }
  validates :sexual_orientation, presence: true, inclusion: { in: ->(student) { student.dynamic_orientations } }
  validates :date_of_birth, presence: true, format: { with: /\A\d{4}-\d{2}-\d{2}\z/ }
  validate :date_of_birth_must_be_at_least_10_years_ago
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

  def load_dynamic_options
    @dynamic_genders = %w[Male Female] + Option.where(field: 'Gender').pluck(:options).flat_map { |opt| opt.split(', ') }
    @dynamic_ethnicities = ['Asian', 'Black', 'Hispanic/Latino', 'Native American', 'White', 'Other'] + Option.where(field: 'Ethnicity').pluck(:options).flat_map { |opt| opt.split(', ') }
    @dynamic_nationalities = %w[American British Canadian Australian French German Japanese Chinese Indian Other] + Option.where(field: 'Nationality').pluck(:options).flat_map { |opt| opt.split(', ') }
    @dynamic_classifications = %w[Freshman Sophomore Junior Senior Graduate] + Option.where(field: 'University Classification').pluck(:options).flat_map { |opt| opt.split(', ') }
    @dynamic_statuses = %w[Active Inactive] + Option.where(field: 'Status').pluck(:options).flat_map { |opt| opt.split(', ') }
    @dynamic_orientations = %w[Heterosexual Homosexual] + Option.where(field: 'Sexual Orientation').pluck(:options).flat_map { |opt| opt.split(', ') }
  end

  def expected_graduation_must_be_in_the_future
    if expected_graduation.present? && expected_graduation <= Time.zone.today
      errors.add(:expected_graduation, 'must be in the future')
    end
  end

  def date_of_birth_must_be_at_least_10_years_ago
    if date_of_birth.present? && date_of_birth > 10.years.ago.to_date
      errors.add(:date_of_birth, 'must be at least 10 years ago')
    end
  end

  # Methods to provide the dynamic options for validations
  def dynamic_genders
    @dynamic_genders
  end

  def dynamic_ethnicities
    @dynamic_ethnicities
  end

  def dynamic_nationalities
    @dynamic_nationalities
  end

  def dynamic_classifications
    @dynamic_classifications
  end

  def dynamic_statuses
    @dynamic_statuses
  end

  def dynamic_orientations
    @dynamic_orientations
  end
end
