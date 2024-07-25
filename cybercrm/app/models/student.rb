# frozen_string_literal: true

# app/models/student.rb
class Student < ApplicationRecord
  has_many :student_options, dependent: :destroy
  has_many :options, through: :student_options
  has_many :notes, dependent: :destroy

  validates :name, presence: true, length: { minimum: 4, maximum: 200 }
  validates :uin, presence: true, numericality: { only_integer: true }, length: { is: 9 }, uniqueness: true
  validates :grade_ryg, inclusion: { in: %w[G Y R] }
  validates :gender, presence: true,
                     inclusion: { in: %w[Male Female] + Option.where(option_type: 'Gender').pluck(:name) }
  validates :ethnicity, presence: true,
                        inclusion: { in: ['Asian', 'Black', 'Hispanic/Latino', 'Native American', 'White', 'Other'] + Option.where(option_type: 'Ethnicity').pluck(:name) }
  validates :nationality, presence: true,
                          inclusion: { in: %w[American British Canadian Australian French German Japanese Chinese Indian Other] + Option.where(option_type: 'Nationality').pluck(:name) }
  validates :expected_graduation, presence: true, format: { with: /\A\d{4}-\d{2}-\d{2}\z/ }
  validate lambda {
             if expected_graduation.present? && expected_graduation <= Time.zone.today
               errors.add(:expected_graduation, 'must be in the future')
             end
           }
  validates :university_classification, presence: true,
                                        inclusion: { in: %w[Freshman Sophomore Junior Senior Graduate] + Option.where(option_type: 'University Classification').pluck(:name) }
  validates :status, presence: true,
                     inclusion: { in: %w[Active Inactive] + Option.where(option_type: 'Status').pluck(:name) }
  validates :sexual_orientation, presence: true,
                                 inclusion: { in: %w[Heterosexual Homosexual] + Option.where(option_type: 'Sexual Orientation').pluck(:name) }
  validates :date_of_birth, presence: true, format: { with: /\A\d{4}-\d{2}-\d{2}\z/ }
  validate lambda {
             if date_of_birth.present? && date_of_birth > 10.years.ago.to_date
               errors.add(:date_of_birth, 'must be at least 10 years ago')
             end
           }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

  # Method to get the value of a custom attribute
  def custom_attribute_value(attribute_name)
    option = Option.find_by(name: attribute_name, option_type: 'CustomAttribute')
    return nil unless option

    student_options.find_by(option:)&.value
  end
end
