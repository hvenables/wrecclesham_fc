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

ActiveRecord::Schema.define(version: 20160508004619) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fixtures", force: :cascade do |t|
    t.date     "date"
    t.string   "home"
    t.string   "away"
    t.string   "home_score"
    t.string   "away_score"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "league_table_id"
    t.index ["league_table_id"], name: "index_fixtures_on_league_table_id", using: :btree
  end

  create_table "league_tables", force: :cascade do |t|
    t.integer  "year"
    t.string   "name"
    t.integer  "promoted"
    t.integer  "relegated"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "url"
    t.string   "fixture_url"
    t.integer  "number_of_teams"
    t.boolean  "active_first_team_table",   default: false, null: false
    t.boolean  "active_reserve_team_table", default: false, null: false
  end

  create_table "news", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "team"
    t.integer  "games"
    t.integer  "won"
    t.integer  "drawn"
    t.integer  "lost"
    t.integer  "goals_for"
    t.integer  "goals_against"
    t.integer  "goal_difference"
    t.integer  "points"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "league_table_id"
    t.index ["league_table_id"], name: "index_teams_on_league_table_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.boolean  "admin",                  default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "fixtures", "league_tables"
  add_foreign_key "teams", "league_tables"
end
