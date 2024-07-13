# frozen_string_literal: true

FactoryBot.define do
  factory :student do
    name { 'John Doe' }
    sequence(:uin) { |n| "1234567#{n.to_s.rjust(2, '0')}" } # Ensuring UIN is always 9 characters long
    grade_ryg { 'G' }
    gender { 'Male' }
    ethnicity { 'Asian' }
    nationality { 'American' }
    expected_graduation { '2025-05-15' }
    university_classification { 'Senior' }
    status { 'Active' }
    sexual_orientation { 'Heterosexual' }
    date_of_birth { '2000-01-01' }
    sequence(:email) { |n| "john.doe#{n}@example.com" }
  end
end
