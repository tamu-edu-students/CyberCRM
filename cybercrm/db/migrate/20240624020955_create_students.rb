# frozen_string_literal: true

# Create Student
class CreateStudents < ActiveRecord::Migration[7.1]
  # rubocop:disable Metrics/MethodLength
  def change
    create_table :students do |t|
      t.string :name
      t.integer :age
      t.string :grade
      t.string :uin, unique: true
      t.decimal :gpa
      t.string :gender
      t.string :ethnicity
      t.string :nationality
      t.date :expected_graduation
      t.string :university_classification

      t.timestamps
    end
  end
  # rubocop:enable Metrics/MethodLength
end
