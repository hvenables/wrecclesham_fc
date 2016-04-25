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

ActiveRecord::Schema.define(version: 20160424220158) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "league_tables", force: :cascade do |t|
    t.integer  "year"
    t.string   "name"
    t.integer  "promoted"
    t.integer  "relegated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "url"
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
  end

  add_index "teams", ["league_table_id"], name: "index_teams_on_league_table_id", using: :btree

  add_foreign_key "teams", "league_tables"
end