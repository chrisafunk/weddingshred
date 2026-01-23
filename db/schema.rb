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

ActiveRecord::Schema[8.1].define(version: 2026_01_23_180505) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "exercises", force: :cascade do |t|
    t.string "category"
    t.text "coaching_cues"
    t.text "contraindications"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "equipment", default: [], array: true
    t.integer "exercise_type", default: 0, null: false
    t.jsonb "joint_angles", default: {}
    t.integer "movement_pattern", default: 0, null: false
    t.string "name"
    t.integer "plane_of_motion", default: 0, null: false
    t.string "primary_muscles", default: [], array: true
    t.string "purposes", default: [], array: true
    t.text "range_of_motion"
    t.boolean "requires_spotter", default: false, null: false
    t.string "secondary_muscles", default: [], array: true
    t.integer "starting_position", default: 0, null: false
    t.integer "technical_complexity", default: 0, null: false
    t.string "thumbnail_url"
    t.boolean "unilateral", default: false, null: false
    t.string "unit"
    t.datetime "updated_at", null: false
    t.string "video_url"
    t.index ["equipment"], name: "index_exercises_on_equipment", using: :gin
    t.index ["joint_angles"], name: "index_exercises_on_joint_angles", using: :gin
    t.index ["primary_muscles"], name: "index_exercises_on_primary_muscles", using: :gin
    t.index ["purposes"], name: "index_exercises_on_purposes", using: :gin
    t.index ["secondary_muscles"], name: "index_exercises_on_secondary_muscles", using: :gin
    t.index ["thumbnail_url"], name: "index_exercises_on_thumbnail_url"
  end

  create_table "memberships", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "is_group_admin", default: false, null: false
    t.string "status"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "wedding_group_id", null: false
    t.index ["user_id"], name: "index_memberships_on_user_id"
    t.index ["wedding_group_id"], name: "index_memberships_on_wedding_group_id"
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

  create_table "wedding_groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "location"
    t.string "name"
    t.datetime "updated_at", null: false
    t.date "wedding_date"
  end

  add_foreign_key "memberships", "users"
  add_foreign_key "memberships", "wedding_groups"
end
