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

# Clear existing data
Program.destroy_all

# Create programs
Program.create(name: 'SFS', description: 'Scholarship for Service Program')
Program.create(name: 'CLDP', description: 'Community Leadership Development Program')
Program.create(name: 'VICEROY', description: 'VICEROY Program')

Rails.logger.debug 'Student table reset'
Student.destroy_all

# rubocop:disable Metrics/BlockLength
nationalities = %w[American British Canadian Australian French German Japanese Chinese Indian
                   Other]
ethnicities = ['Asian', 'Black', 'Hispanic/Latino', 'Native American', 'White', 'Other']

50.times do |i|
  name_first = Faker::Name.male_first_name
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

  nationality = nationalities.sample

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

  Student.create!(
    name: name_full,
    uin:,
    gpa:,
    grade_ryg:,
    gender: 'Male',
    ethnicity:,
    nationality:,
    expected_graduation: Faker::Date.between(from: '2026-08-23', to: '2029-05-23'),
    university_classification: classification,
    status:,
    sexual_orientation:,
    date_of_birth: Faker::Date.between(from: '1995-01-01', to: '2005-01-01'),
    email:
  )
end
students = Student.all
students.each do |student|
  Rails.logger.debug student.name
  student.notes.build(note: "#{student.name} has finals", note_created_date: Date.new(2024, 5, 14),
                      followup_action: "Check up on #{student.name} to see if they are prepared",
                      followup_date: Date.new(2024, 5, 21), action_completed: true, status: 'Active')
  student.notes.build(note: "Check that #{student.name} is well after finals",
                      note_created_date: Date.new(2024, 6, 4),
                      followup_action: "Send #{student.name} an email at #{student.email}",
                      followup_date: Date.new(2024, 6, 7), action_completed: false, status: 'Active')
  student.save!
end
# rubocop:enable Metrics/BlockLength

Rails.logger.debug { "There are #{Student.count} students" }
