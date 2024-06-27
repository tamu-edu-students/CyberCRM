# frozen_string_literal: true

json.extract! student, :id, :name, :uin, :grade, :gender, :ethnicity, :nationality, :expected_graduation,
              :university_classification, :status, :sexual_orientation, :date_of_birth, :internships, 
              :corps, :security_clearance, :created_at, :updated_at
json.url student_url(student, format: :json)
