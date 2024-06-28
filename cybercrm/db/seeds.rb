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
(0...10).each do |_|
  Student.create!([
                    {
                      name: "#{Faker::Name.male_first_name} #{Faker::Name.last_name}",
                      uin: Faker::Number.number(digits: 8),
                      grade_ryg: %w[R Y G].sample,
                      gender: %w[Male Female].sample,
                      ethnicity: Faker::Demographic.race,
                      nationality: Faker::Nation.nationality,
                      expected_graduation: Faker::Date.between(from: '2023-08-23', to: '2026-05-23'),
                      university_classification: %w[Freshman Sophmore Junior Senior].sample,
                      status: 'Active',
                      sexual_orientation: %w[Heterosexual Homosexual].sample,
                      date_of_birth: Faker::Date.between(from: '1990-01-01', to: '2001-01-01'),
                      internships: %w[Yes No].sample,
                      corps: %w[Yes No].sample,
                      security_clearance: %w[Yes No].sample
                    }
                  ])
end
p "There are #{Student.count} students"
