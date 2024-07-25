# frozen_string_literal: true

class CreateOptionsAndStudentOptions < ActiveRecord::Migration[7.1]
  def change
    # Create options table
    create_table :options do |t|
      t.string :display_type
      t.string :field
      t.text :options

      t.timestamps
    end

    # Create student_options table
    create_table :student_options do |t|
      t.references :student, null: false, foreign_key: true
      t.references :option, null: false, foreign_key: true
      t.string :value

      t.timestamps
    end
  end
end
