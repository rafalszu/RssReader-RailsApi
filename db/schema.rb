# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170704211759) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entries", force: :cascade do |t|
    t.string "title"
    t.string "permanent_url"
    t.string "content"
    t.boolean "read"
    t.bigint "feed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.boolean "deleted", default: false
    t.string "summary"
    t.index ["feed_id"], name: "index_entries_on_feed_id"
    t.index ["user_id"], name: "index_entries_on_user_id"
  end

  create_table "feeds", force: :cascade do |t|
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.bigint "user_id"
    t.boolean "deleted", default: false
    t.index ["user_id"], name: "index_feeds_on_user_id"
  end

  create_table "logins", force: :cascade do |t|
    t.string "identification", null: false
    t.string "password_digest"
    t.string "oauth2_token", null: false
    t.string "uid"
    t.string "single_use_oauth2_token"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.index ["user_id"], name: "index_logins_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "entries", "users"
  add_foreign_key "feeds", "users"
end
