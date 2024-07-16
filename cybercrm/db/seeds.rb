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

Rails.logger.debug 'Student table reset'
Student.destroy_all
Program.destroy_all
StudentProgram.destroy_all

# Create Programs
programs = %w[SFS CLDP VICEROY].map do |program_name|
  Program.create!(name: program_name)
end

# rubocop:disable Metrics/BlockLength
nationalities = %w[American British Canadian Australian French German Japanese Chinese Indian
                   Other]
ethnicities = ['Asian', 'Black', 'Hispanic/Latino', 'Native American', 'White', 'Other']

50.times do |i|
  name_first = Faker::Name.first_name
  name_last = Faker::Name.last_name
  name_full = "#{name_first} #{name_last}"
  uin = Faker::Number.number(digits: 9).to_s
  gpa = Faker::Number.between(from: 2.50, to: 4.00).round(2)

  grade_ryg = if gpa >= 3.30 && gpa <= 4.00
                'G'
              elsif gpa >= 2.80 && gpa < 3.20
                'Y'
              else
                'R'
              end


  nationality = Student::NATIONALITY_OPTIONS.sample
  ethnicity = Student::ETHNICITY_OPTIONS.sample


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
  ethnicity = ethnicities.sample

  student = Student.create!(
    name: name_full,
    uin:,
    grade_ryg:,

    gender: 'Male', 
    ethnicity:,
    nationality:,
    expected_graduation: Faker::Date.between(from: 2.years.from_now, to: 4.years.from_now),

    university_classification: classification,
    status:,
    sexual_orientation:,
    date_of_birth: Faker::Date.between(from: '1995-01-01', to: '2005-01-01'),
    email:
  )

  # Assign programs to students
  student.programs << programs.sample(rand(1..3)) # Assign 1 to 3 random programs to each student
end
# rubocop:enable Metrics/BlockLength

Rails.logger.debug { "There are #{Student.count} students" }
