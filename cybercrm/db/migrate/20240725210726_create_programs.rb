class CreatePrograms < ActiveRecord::Migration[7.1]
  def change
    create_table :programs do |t|
      t.string :name, null: false
      t.text :description, null: false

      t.timestamps
    end

    add_index :programs, :name, unique: true
  end
end
