# frozen_string_literal: true

# Remove Age
class RemoveAgeFromStudents < ActiveRecord::Migration[7.1]
  def change
    remove_column :students, :age, :integer
  end
end
