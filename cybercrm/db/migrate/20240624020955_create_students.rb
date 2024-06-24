# frozen_string_literal: true

# Create Student
class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :students do |t|
      t.string :name
      t.integer :age
      t.string :grade
      t.integer :uin
      t.decimal :gpa
      t.string :gender
      t.string :ethnicity
      t.string :nationality
      t.date :expected_graduation
      t.string :university_classification

      t.timestamps
    end
  end
end
