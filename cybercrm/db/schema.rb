# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.


ActiveRecord::Schema[7.1].define(version: 2024_07_14_002805) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "custom_attributes", force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false

  end
  
  create_table "student_custom_attributes", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "custom_attribute_id", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["custom_attribute_id"], name: "index_student_custom_attributes_on_custom_attribute_id"
    t.index ["student_id"], name: "index_student_custom_attributes_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "uin"
    t.decimal "gpa"
    t.string "gender"
    t.string "ethnicity"
    t.string "nationality"
    t.date "expected_graduation"
    t.string "university_classification"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.string "sexual_orientation"
    t.date "date_of_birth"
    t.string "grade_ryg"
    t.string "email"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "email"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.string "note"
    t.date "note_created_date"
    t.string "followup_action"
    t.date "followup_date"
    t.boolean "action_completed"
    t.boolean "is_private"
    t.string "private_note_user"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_notes_on_student_id"
  end

  add_foreign_key "notes", "students"
  add_foreign_key "student_custom_attributes", "custom_attributes"
  add_foreign_key "student_custom_attributes", "students"
end
