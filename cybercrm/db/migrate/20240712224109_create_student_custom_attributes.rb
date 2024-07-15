# frozen_string_literal: true

# creates the student custom attributes
class CreateStudentCustomAttributes < ActiveRecord::Migration[7.1]
  def change
    create_table :student_custom_attributes do |t|
      t.references :student, null: false, foreign_key: true
      t.references :custom_attribute, null: false, foreign_key: true
      t.string :value

      t.timestamps
    end
  end
end
