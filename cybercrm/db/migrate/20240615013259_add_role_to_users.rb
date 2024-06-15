# frozen_string_literal: true

# Adds a role to users
class AddRoleToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :string
  end
end
