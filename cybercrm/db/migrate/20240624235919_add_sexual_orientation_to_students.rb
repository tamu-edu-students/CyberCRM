# frozen_string_literal: true

# Sexual Orientation
class AddSexualOrientationToStudents < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :sexual_orientation, :string
  end
end