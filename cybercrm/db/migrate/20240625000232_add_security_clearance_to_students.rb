class AddSecurityClearanceToStudents < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :security_clearance, :string
  end
end
