class RemoveSecurityClearanceFromStudents < ActiveRecord::Migration[7.1]
  def change
    remove_column :students, :security_clearance, :string
  end
end
