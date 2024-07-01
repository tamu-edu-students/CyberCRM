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

require 'faker'

puts 'Student table reset'
Student.destroy_all

# rubocop:disable Metrics/BlockLength
50.times do |i|
  name_first = Faker::Name.male_first_name
  name_last = Faker::Name.last_name
  name_full = "#{name_first} #{name_last}"
  uin = Faker::Number.number(digits: 8).to_s
  gpa = Faker::Number.between(from: 2.50, to: 4.00).round(2)

  grade_ryg = if gpa >= 3.30 && gpa <= 4.00
                'G'
              elsif gpa >= 2.80 && gpa < 3.20
                'Y'
              else
                'R'
              end

  nationality = Faker::Nation.nationality
  nationality = nationality.chop if nationality[-1] == 's'

  classification = case i % 4
                   when 0
                     'Graduate'
                   when 1
                     'Senior'
                   when 2
                     'Junior'
                   when 3
                     'Sophomore'
                   end

  status = (i % 5).zero? ? 'Inactive' : 'Active'
  sexual_orientation = i % 9 == 1 ? 'Homosexual' : 'Heterosexual'
  email = "#{name_first[0].downcase}#{name_last.downcase}@tamu.edu"

  Student.create!(
    name: name_full,
    uin:,
    gpa:,
    grade_ryg:,
    gender: 'Male',
    ethnicity: Faker::Demographic.race,
    nationality:,
    expected_graduation: Faker::Date.between(from: '2023-08-23', to: '2026-05-23'),
    university_classification: classification,
    status:,
    sexual_orientation:,
    date_of_birth: Faker::Date.between(from: '1995-01-01', to: '2005-01-01'),
    email:
  )
end
# rubocop:enable Metrics/BlockLength

puts "There are #{Student.count} students"
