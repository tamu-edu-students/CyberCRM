class CreateStudentOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :student_options do |t|
      t.references :student, null: false, foreign_key: true
      t.references :option, null: false, foreign_key: true
      t.string :value

      t.timestamps
    end
  end
end
