# frozen_string_literal: true

# Corps
class AddCorpsToStudents < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :corps, :string
  end
end
