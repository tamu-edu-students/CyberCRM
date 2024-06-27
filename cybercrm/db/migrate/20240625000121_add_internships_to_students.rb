# frozen_string_literal: true

class AddInternshipsToStudents < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :internships, :string
  end
end
