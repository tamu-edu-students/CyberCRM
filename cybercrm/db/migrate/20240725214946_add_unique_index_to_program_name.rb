class AddUniqueIndexToProgramName < ActiveRecord::Migration[7.1]
  def change
    add_index :programs, :name, unique: true
  end
end
