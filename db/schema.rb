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

ActiveRecord::Schema.define(version: 2021_03_28_190835) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "bootcamps", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.string "city"
    t.string "website"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "chat_messages", force: :cascade do |t|
    t.bigint "user_sender_id", null: false
    t.bigint "user_receiver_id", null: false
    t.text "content", null: false
    t.datetime "sent_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "previous_message_id"
    t.boolean "is_new_message", default: true
    t.index ["user_receiver_id"], name: "index_chat_messages_on_user_receiver_id"
    t.index ["user_sender_id"], name: "index_chat_messages_on_user_sender_id"
  end

  create_table "foreign_key_to_bootcamps_in_users", force: :cascade do |t|
  end

  create_table "join_requests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.boolean "request_pending", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "participants_id"
    t.text "content", null: false
    t.index ["participants_id"], name: "index_join_requests_on_participants_id"
    t.index ["project_id"], name: "index_join_requests_on_project_id"
    t.index ["user_id"], name: "index_join_requests_on_user_id"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.bigint "invite_participant_id"
    t.boolean "is_founder", default: false
    t.datetime "invited_at"
    t.datetime "accepted_at"
    t.string "status", null: false
    t.index ["invite_participant_id"], name: "index_participants_on_invite_participant_id"
    t.index ["project_id"], name: "index_participants_on_project_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "project_tags", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_project_tags_on_project_id"
    t.index ["tag_id"], name: "index_project_tags_on_tag_id"
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
    t.boolean "is_suspended", default: false
    t.string "status_project"
    t.string "category"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.string "first_name"
    t.string "last_name"
    t.string "picture_url"
    t.boolean "admin"
    t.bigint "bootcamps_id"
    t.text "description"
    t.index ["bootcamps_id"], name: "index_users_on_bootcamps_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "join_requests", "participants", column: "participants_id"
  add_foreign_key "join_requests", "projects"
  add_foreign_key "join_requests", "users"
  add_foreign_key "participants", "participants", column: "invite_participant_id"
  add_foreign_key "participants", "projects"
  add_foreign_key "participants", "users"
  add_foreign_key "project_tags", "projects"
  add_foreign_key "project_tags", "tags"
  add_foreign_key "projects", "users"
  add_foreign_key "users", "bootcamps", column: "bootcamps_id"
end
