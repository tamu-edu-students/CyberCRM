class RemoveCorpsFromStudents < ActiveRecord::Migration[7.1]
  def change
    remove_column :students, :corps, :string
  end
end
