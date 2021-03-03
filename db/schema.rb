# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_03_160347) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "join_requests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.boolean "request_pending", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_join_requests_on_project_id"
    t.index ["user_id"], name: "index_join_requests_on_user_id"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.bigint "participant_id"
    t.boolean "is_founder", default: false
    t.datetime "invited_at"
    t.datetime "accepted_at"
    t.index ["participant_id"], name: "index_participants_on_participant_id"
    t.index ["project_id"], name: "index_participants_on_project_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "project_participants", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_participant_id", null: false
    t.bigint "project_id", null: false
    t.boolean "is_founder"
    t.date "invited_on"
    t.date "accepted_on"
    t.string "clearence_level"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_project_participants_on_project_id"
    t.index ["project_participant_id"], name: "index_project_participants_on_project_participant_id"
    t.index ["user_id"], name: "index_project_participants_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.string "description"
    t.string "linkedin_url"
    t.string "github_url"
    t.string "trello_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.string "first_name"
    t.string "last_name"
    t.string "picture_url"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "join_requests", "projects"
  add_foreign_key "join_requests", "users"
  add_foreign_key "participants", "participants"
  add_foreign_key "participants", "projects"
  add_foreign_key "participants", "users"
  add_foreign_key "project_participants", "project_participants"
  add_foreign_key "project_participants", "projects"
  add_foreign_key "project_participants", "users"
  add_foreign_key "projects", "users"
end
