class AddGradeRygToStudents < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :grade_ryg, :string
  end
end
