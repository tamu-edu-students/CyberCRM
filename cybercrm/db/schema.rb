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

ActiveRecord::Schema[7.1].define(version: 2024_06_26_005457) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string "internships"
    t.string "corps"
    t.string "security_clearance"
    t.string "grade_ryg"
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

end
