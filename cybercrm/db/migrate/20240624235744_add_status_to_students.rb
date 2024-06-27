class AddStatusToStudents < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :status, :string
  end
end
