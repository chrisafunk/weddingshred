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

ActiveRecord::Schema[8.1].define(version: 2026_01_16_050714) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "exercises", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.string "name"
    t.string "unit"
    t.datetime "updated_at", null: false
  end

  create_table "month_plans", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "end_date"
    t.date "start_date"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "plan_exercises", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "exercise_id", null: false
    t.bigint "month_plan_id", null: false
    t.integer "target_reps"
    t.integer "target_sets"
    t.decimal "target_weight"
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_plan_exercises_on_exercise_id"
    t.index ["month_plan_id"], name: "index_plan_exercises_on_month_plan_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "current_streak", default: 0, null: false
    t.string "display_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.date "last_logged_on"
    t.string "last_name"
    t.integer "longest_streak", default: 0, null: false
    t.string "name"
    t.string "password_digest"
    t.string "relationship_to_couple"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role", default: 0, null: false
    t.string "time_zone"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  create_table "workout_entries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.decimal "distance_km"
    t.integer "duration_minutes"
    t.bigint "exercise_id", null: false
    t.bigint "month_plan_id", null: false
    t.text "notes"
    t.date "performed_on"
    t.integer "reps"
    t.integer "sets"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.decimal "weight"
    t.index ["exercise_id"], name: "index_workout_entries_on_exercise_id"
    t.index ["month_plan_id"], name: "index_workout_entries_on_month_plan_id"
    t.index ["performed_on"], name: "index_workout_entries_on_performed_on"
    t.index ["user_id", "month_plan_id", "performed_on"], name: "index_entries_user_plan_day"
    t.index ["user_id"], name: "index_workout_entries_on_user_id"
  end

  add_foreign_key "plan_exercises", "exercises"
  add_foreign_key "plan_exercises", "month_plans"
  add_foreign_key "workout_entries", "exercises"
  add_foreign_key "workout_entries", "month_plans"
  add_foreign_key "workout_entries", "users"
end
