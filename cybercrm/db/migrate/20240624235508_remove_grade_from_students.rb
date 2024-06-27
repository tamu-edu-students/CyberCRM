class RemoveGradeFromStudents < ActiveRecord::Migration[7.1]
  def change
    remove_column :students, :grade, :string
  end
end
