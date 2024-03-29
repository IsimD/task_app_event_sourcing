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

ActiveRecord::Schema.define(version: 2019_03_04_205555) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "event_store_events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "event_type", null: false
    t.binary "metadata"
    t.binary "data", null: false
    t.datetime "created_at", null: false
    t.index ["created_at"], name: "index_event_store_events_on_created_at"
    t.index ["event_type"], name: "index_event_store_events_on_event_type"
  end

  create_table "event_store_events_in_streams", id: :serial, force: :cascade do |t|
    t.string "stream", null: false
    t.integer "position"
    t.uuid "event_id", null: false
    t.datetime "created_at", null: false
    t.index ["created_at"], name: "index_event_store_events_in_streams_on_created_at"
    t.index ["stream", "event_id"], name: "index_event_store_events_in_streams_on_stream_and_event_id", unique: true
    t.index ["stream", "position"], name: "index_event_store_events_in_streams_on_stream_and_position", unique: true
  end

  create_table "project_time_trackeds", id: :string, force: :cascade do |t|
    t.string "project_id", null: false
    t.float "time_tracked", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task_time_trackeds", id: :string, force: :cascade do |t|
    t.string "task_id", null: false
    t.float "time_tracked", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_tracking_points", id: :string, force: :cascade do |t|
    t.string "task_id", null: false
    t.string "user_id", null: false
    t.datetime "start_time", null: false
    t.datetime "stop_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.string "auth_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
