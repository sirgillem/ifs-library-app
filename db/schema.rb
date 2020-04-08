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

ActiveRecord::Schema.define(version: 20200401103510) do

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

  create_table "portal_clist", id: false, force: :cascade do |t|
    t.integer "pageid", limit: 2,     default: 0,  null: false
    t.string  "name",   limit: 255,   default: "", null: false
    t.text    "items",  limit: 65535,              null: false
  end

  add_index "portal_clist", ["pageid", "name"], name: "pageid", using: :btree
  add_index "portal_clist", ["pageid", "name"], name: "pageid_2", unique: true, using: :btree

  create_table "portal_comments", force: :cascade do |t|
    t.integer  "repid",     limit: 3,     default: 0,  null: false
    t.text     "commtext",  limit: 65535,              null: false
    t.datetime "posted",                               null: false
    t.string   "ip",        limit: 255,   default: "", null: false
    t.string   "dns",       limit: 255,   default: "", null: false
    t.string   "useragent", limit: 255,   default: "", null: false
    t.string   "referer",   limit: 255,   default: "", null: false
  end

  create_table "portal_config", primary_key: "name", force: :cascade do |t|
    t.string "value", limit: 255, default: "", null: false
  end

  create_table "portal_pages", force: :cascade do |t|
    t.string  "name",        limit: 255,   default: "", null: false
    t.text    "htmltpl",     limit: 65535,              null: false
    t.text    "htmlbody",    limit: 65535,              null: false
    t.text    "rssbody",     limit: 65535,              null: false
    t.text    "links",       limit: 65535,              null: false
    t.integer "repeater",    limit: 1,     default: 0,  null: false
    t.string  "repformat",   limit: 255,   default: "", null: false
    t.text    "repkeys",     limit: 65535,              null: false
    t.integer "commtype",    limit: 1,     default: 0,  null: false
    t.text    "reqcomm",     limit: 65535,              null: false
    t.integer "modpp",       limit: 2,     default: 0,  null: false
    t.integer "modlock",     limit: 1,     default: 0,  null: false
    t.integer "modmin",      limit: 1,     default: 0,  null: false
    t.integer "tarows",      limit: 1,     default: 7,  null: false
    t.string  "redirect",    limit: 255,   default: "", null: false
    t.integer "retype",      limit: 1,     default: 0,  null: false
    t.integer "private",     limit: 1,     default: 0,  null: false
    t.integer "level",       limit: 2,     default: 0,  null: false
    t.integer "nocache",     limit: 1,     default: 0,  null: false
    t.integer "overridetpl", limit: 1,     default: 0,  null: false
  end

  add_index "portal_pages", ["name"], name: "name_2", unique: true, using: :btree

  create_table "portal_repdata", force: :cascade do |t|
    t.integer "pageid",  limit: 3,     default: 0, null: false
    t.integer "oid",     limit: 2,     default: 0, null: false
    t.text    "modules", limit: 65535,             null: false
  end

  add_index "portal_repdata", ["pageid", "oid"], name: "repid", using: :btree

  create_table "portal_users", force: :cascade do |t|
    t.string  "uname",     limit: 255,   default: "", null: false
    t.string  "passwort",  limit: 41,    default: "", null: false
    t.string  "email",     limit: 255,   default: "", null: false
    t.integer "viewlvl",   limit: 2,     default: 0,  null: false
    t.integer "basiclvl",  limit: 2,     default: 0,  null: false
    t.integer "advlvl",    limit: 2,     default: 0,  null: false
    t.integer "superuser", limit: 1,     default: 0,  null: false
    t.integer "cpage",     limit: 1,     default: 0,  null: false
    t.text    "notes",     limit: 65535,              null: false
  end

  add_index "portal_users", ["uname"], name: "uname", using: :btree

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

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
