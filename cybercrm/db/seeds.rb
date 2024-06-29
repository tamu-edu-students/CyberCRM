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
(0...10).each do |i|
  tNameFirst = Faker::Name.male_first_name
  tNameLast = Faker::Name.last_name
  tNameFull = "#{tNameFirst} #{tNameLast}"
  tUin = Faker::Number.number(digits: 8).to_s
  tGpa = Faker::Number.between(from: 2.50, to: 4.00).round(2)
  tGrade_ryg = 'R'
  if tGpa >= 3.30 && tGpa <= 4.00
    tGrade_ryg = 'G'
  elsif tGpa >= 2.80 && tGpa < 3.20
    tGrade_ryg = 'Y'
  end

  tNationality = Faker::Nation.nationality
  _
  tNationality = tNationality.chop if tNationality[-1] == 's'
  tClassification = 'Senior'
  if (i % 4).zero?
    tClassification = 'Graduate'
  elsif i % 4 == 1
    tClassification = 'Senior'
  elsif i % 4 == 2
    tClassification = 'Junior'
  elsif i % 4 == 3
    tClassification = 'Sophmore'
  end
  tStatus = if (i % 5).zero?
              'Inactive'
            else
              'Active'
            end
  tSexualOrientation = if i % 9 == 1
                         'Homosexual'
                       else
                         'Heterosexual'
                       end
  tEmail = "#{tNameFirst[0].downcase}#{tNameLast.downcase}@tamu.edu"
  Student.create!([
                    {
                      name: tNameFull,
                      uin: tUin,
                      gpa: tGpa,
                      grade_ryg: tGrade_ryg,
                      gender: 'Male',
                      ethnicity: Faker::Demographic.race,
                      nationality: tNationality,
                      expected_graduation: Faker::Date.between(from: '2023-08-23', to: '2026-05-23'),
                      university_classification: tClassification,
                      status: tStatus,
                      sexual_orientation: tSexualOrientation,
                      date_of_birth: Faker::Date.between(from: '1995-01-01', to: '2005-01-01'),
                      email: tEmail
                    }
                  ])
end
puts "There are #{Student.count} students"
