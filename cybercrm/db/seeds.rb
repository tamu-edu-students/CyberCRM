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

require "faker"
for i in 0 ... 1
    Student.create!([
        {
        name: Faker::Name.male_first_name + " " + Faker::Name.last_name,	
        uin:  Faker::Alphanumeric.alphanumeric(number: 8),
        gpa: Faker::Number.between(from: 2.50, to: 4.00) , #2.00, 4.00
        grade_ryg: "G",
        gender: "Male",
        ethnicity: Faker::Demographic.race ,
        nationality: Faker::Nation.nationality ,
        expected_graduation: Faker::Date.between(from: '2023-08-23', to: '2026-05-23') ,
        university_classification: "Senior" ,
        status: "Student" ,
        sexual_orientation: "Heterosexual" ,
        date_of_birth: Faker::Date.between(from: '1990-01-01', to: '2002-01-01') ,
        internships: "Yes" ,
        corps: "Yes" ,
        security_clearance: "Yes" 
        }
    ])
end
p "There are #{Student.count} students"