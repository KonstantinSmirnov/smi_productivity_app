# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160306090124) do

  create_table "comments", force: :cascade do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.string   "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "connections", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "workspace_id"
    t.integer  "role",         default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "connections", ["user_id", "workspace_id"], name: "index_connections_on_user_id_and_workspace_id", unique: true

  create_table "projects", force: :cascade do |t|
    t.integer  "workspace_id"
    t.string   "title"
    t.string   "description"
    t.integer  "condition",    default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "color"
    t.string   "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "title"
    t.date     "due_date"
    t.boolean  "done?",       default: false
    t.string   "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",               null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "name"
    t.string   "title"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "workspace_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "workspaces", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
