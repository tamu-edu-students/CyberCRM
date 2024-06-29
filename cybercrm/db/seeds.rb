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
  Name_First = Faker::Name.male_first_name
  Name_Last = Faker::Name.last_name
  Name_Full = "#{Name_First} #{Name_Last}".freeze
  UIN = Faker::Number.number(digits: 8).to_s
  GPA = Faker::Number.between(from: 2.50, to: 4.00).round(2)
  Grade_ryg = 'R'
  if GPA >= 3.30 && GPA <= 4.00
    Grade_ryg = 'G'
  elsif GPA >= 2.80 && GPA < 3.20
    Grade_ryg = 'Y'
  end

  Nationality = Faker::Nation.nationality
  Nationality = Nationality.chop if Nationality[-1] == 's'
  Classification = 'Senior'
  if (i % 4).zero?
    Classification = 'Graduate'
  elsif i % 4 == 1
    Classification = 'Senior'
  elsif i % 4 == 2
    Classification = 'Junior'
  elsif i % 4 == 3
    Classification = 'Sophmore'
  end
  Status = if (i % 5).zero?
             'Inactive'
           else
             'Active'
           end
  Sexual_Orientation = if i % 9 == 1
                         'Homosexual'
                       else
                         'Heterosexual'
                       end
  Email = "#{Name_First[0].downcase}#{Name_Last.downcase}@tamu.edu".freeze
  Student.create!([
                    {
                      name: Name_Full,
                      uin: UIN,
                      gpa: GPA,
                      grade_ryg: Grade_ryg,
                      gender: 'Male',
                      ethnicity: Faker::Demographic.race,
                      nationality: Nationality,
                      expected_graduation: Faker::Date.between(from: '2023-08-23', to: '2026-05-23'),
                      university_classification: Classification,
                      status: Status,
                      sexual_orientation: Sexual_Orientation,
                      date_of_birth: Faker::Date.between(from: '1995-01-01', to: '2005-01-01'),
                      email: Email
                    }
                  ])
end
puts "There are #{Student.count} students"
