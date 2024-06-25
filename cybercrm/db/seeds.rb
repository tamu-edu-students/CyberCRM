# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Student.create([
                 {
                   name: 'George Sullivan',
                   age: 20,
                   grade: 'A',
                   uin: 123_456_789,
                   gpa: 3.5,
                   gender: 'Male',
                   ethnicity: 'Caucasian',
                   nationality: 'American',
                   expected_graduation: '2025-05-15',
                   university_classification: 'Sophomore'
                 },
                 {
                   name: 'Maya Chen',
                   age: 22,
                   grade: 'B',
                   uin: 987_654_321,
                   gpa: 3.8,
                   gender: 'Female',
                   ethnicity: 'Asian',
                   nationality: 'Canadian',
                   expected_graduation: '2024-12-20',
                   university_classification: 'Senior'
                 },
                 {
                   name: 'Imani Williams',
                   age: 21,
                   grade: 'A',
                   uin: 123_123_123,
                   gpa: 3.9,
                   gender: 'Female',
                   ethnicity: 'African American',
                   nationality: 'British',
                   expected_graduation: '2025-07-30',
                   university_classification: 'Junior'
                 }
               ])
