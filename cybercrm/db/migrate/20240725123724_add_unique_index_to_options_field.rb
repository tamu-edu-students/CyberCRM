class AddUniqueIndexToOptionsField < ActiveRecord::Migration[7.1]
  def change
    add_index :options, :field, unique: true
  end
end
