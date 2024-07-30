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

ActiveRecord::Schema[7.1].define(version: 2024_07_30_014004) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "notes", force: :cascade do |t|
    t.string "note"
    t.date "note_created_date"
    t.string "followup_action"
    t.date "followup_date"
    t.boolean "action_completed"
    t.boolean "is_private"
    t.string "private_note_user"
    t.string "status"
    t.bigint "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_notes_on_student_id"
  end

  create_table "options", force: :cascade do |t|
    t.string "display_type"
    t.string "field"
    t.text "options"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["field"], name: "index_options_on_field", unique: true
  end

  create_table "programs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_options", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "option_id", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_id"], name: "index_student_options_on_option_id"
    t.index ["student_id"], name: "index_student_options_on_student_id"
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
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["uin"], name: "index_students_on_uin", unique: true
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
    t.string "role_list", default: ["student_worker"], array: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "notes", "students"
  add_foreign_key "student_options", "options"
  add_foreign_key "student_options", "students"
end
