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

ActiveRecord::Schema.define(version: 20200416095258) do

  create_table "packs", force: :cascade do |t|
    t.string   "name",         limit: 255, null: false
    t.integer  "publisher_id", limit: 4,   null: false
    t.string   "serial",       limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "packs", ["publisher_id"], name: "index_library_packs_on_publisher_id", using: :btree

  create_table "publishers", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.string   "website",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "publishers", ["name"], name: "index_library_publishers_on_name", unique: true, using: :btree

  create_table "song_parts", force: :cascade do |t|
    t.integer  "song_id",          limit: 4
    t.string   "name",             limit: 255
    t.boolean  "scanned"
    t.text     "notes",            limit: 65535
    t.integer  "song_template_id", limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "song_parts", ["song_id"], name: "index_library_song_parts_on_song_id", using: :btree
  add_index "song_parts", ["song_template_id"], name: "index_library_song_parts_on_song_template_id", using: :btree

  create_table "song_templates", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "songs", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.string   "label",        limit: 255
    t.integer  "publisher_id", limit: 4
    t.string   "serial",       limit: 255
    t.text     "details",      limit: 65535
    t.text     "notes_perf",   limit: 65535
    t.text     "notes_lib",    limit: 65535
    t.integer  "pack_id",      limit: 4
    t.string   "recording",    limit: 255
    t.string   "style",        limit: 255
    t.integer  "duration",     limit: 4
    t.integer  "tempo",        limit: 4
    t.date     "purchased_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "songs", ["label"], name: "index_library_songs_on_label", using: :btree
  add_index "songs", ["pack_id"], name: "index_library_songs_on_pack_id", using: :btree
  add_index "songs", ["publisher_id"], name: "index_library_songs_on_publisher_id", using: :btree
  add_index "songs", ["title"], name: "index_library_songs_on_title", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "username",               limit: 255
    t.boolean  "admin",                              default: false, null: false
    t.boolean  "librarian",                          default: false, null: false
    t.string   "invitation_token",       limit: 255
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit",       limit: 4
    t.integer  "invited_by_id",          limit: 4
    t.string   "invited_by_type",        limit: 255
    t.integer  "invitations_count",      limit: 4,   default: 0
  end

  add_index "users", ["email"], name: "index_library_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_library_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_library_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_library_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_library_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "packs", "publishers"
  add_foreign_key "song_parts", "song_templates"
  add_foreign_key "song_parts", "songs"
  add_foreign_key "songs", "packs"
  add_foreign_key "songs", "publishers"
end
