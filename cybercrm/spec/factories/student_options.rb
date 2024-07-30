# frozen_string_literal: true

# spec/factories/student_options.rb

FactoryBot.define do
  factory :student_option do
    student
    option
    value { 'Sample Value' }
  end
end
