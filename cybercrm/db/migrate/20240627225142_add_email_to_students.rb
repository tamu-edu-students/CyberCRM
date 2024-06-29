# frozen_string_literal: true

class AddEmailToStudents < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :email, :string
  end
end
