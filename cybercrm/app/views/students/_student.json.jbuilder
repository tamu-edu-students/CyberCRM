# frozen_string_literal: true

json.extract! student, :id, :name, :age, :grade, :uin, :gpa, :gender, :ethnicity, :nationality, :expected_graduation,
              :university_classification, :created_at, :updated_at
json.url student_url(student, format: :json)
