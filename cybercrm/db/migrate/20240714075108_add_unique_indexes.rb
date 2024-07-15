class AddUniqueIndexes < ActiveRecord::Migration[7.1]
  def change
    add_index :custom_attributes, :name, unique: true
    add_index :users, :email, unique: true
  end
end
