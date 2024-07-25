class CreateOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :options do |t|
      t.string :name
      t.string :option_type
      t.string :display_type

      t.timestamps
    end
  end
end
