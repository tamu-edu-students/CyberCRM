# frozen_string_literal: true

FactoryBot.define do
  factory :student_custom_attribute do
    student
    custom_attribute
    value { 'Custom Value' }
  end
end
