# frozen_string_literal: true

# Remove internships
class RemoveInternshipsFromStudents < ActiveRecord::Migration[7.1]
  def change
    remove_column :students, :internships, :string
  end
end
