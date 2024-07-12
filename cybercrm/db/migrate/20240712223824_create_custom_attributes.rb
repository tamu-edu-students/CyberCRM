# frozen_string_literal: true

# Creates custom attributes table
class CreateCustomAttributes < ActiveRecord::Migration[7.1]
  def change
    create_table :custom_attributes do |t|
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end
end
