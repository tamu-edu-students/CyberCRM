# frozen_string_literal: true

class AddDateOfBirthToStudents < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :date_of_birth, :date
  end
end
