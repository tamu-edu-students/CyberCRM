# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
# Create note table
class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.references :student,
                   null: false,
                   foreign_key: true
      t.string :note
      t.date :note_created_date
      t.string :followup_action
      t.date :followup_date
      t.boolean :action_completed
      t.boolean :is_private
      t.string :private_note_user
      t.string :status

      t.timestamps
    end
  end
end
# rubocop:enable Metrics/MethodLength
