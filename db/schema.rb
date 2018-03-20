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

ActiveRecord::Schema.define(version: 20170809194711) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abouts", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "competitions", id: :serial, force: :cascade do |t|
    t.string "type"
    t.integer "year"
    t.string "name"
    t.string "abbreviation"
    t.string "url"
    t.string "fixture_url"
    t.string "result_url"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fixtures", id: :serial, force: :cascade do |t|
    t.date "date"
    t.integer "home_id"
    t.integer "away_id"
    t.string "home_score"
    t.string "away_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "competition_id"
    t.index ["competition_id"], name: "index_fixtures_on_competition_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "title"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.integer "subject_id"
    t.string "subject_type"
  end

  create_table "news", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "seasons", id: :serial, force: :cascade do |t|
    t.integer "games", default: 0
    t.integer "won", default: 0
    t.integer "drawn", default: 0
    t.integer "lost", default: 0
    t.integer "goals_for", default: 0
    t.integer "goals_against", default: 0
    t.integer "goals_difference", default: 0
    t.integer "points", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "league_table_id"
    t.integer "team_id"
    t.integer "home_wins", default: 0
    t.integer "home_drawn", default: 0
    t.integer "home_lost", default: 0
    t.integer "home_goals_for", default: 0
    t.integer "home_goals_against", default: 0
    t.integer "away_wins", default: 0
    t.integer "away_drawn", default: 0
    t.integer "away_lost", default: 0
    t.integer "away_goals_for", default: 0
    t.integer "away_goals_against", default: 0
    t.integer "position"
  end

  create_table "team_competitions", id: :serial, force: :cascade do |t|
    t.integer "team_id"
    t.integer "competition_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competition_id"], name: "index_team_competitions_on_competition_id"
    t.index ["team_id"], name: "index_team_competitions_on_team_id"
  end

  create_table "teams", id: :serial, force: :cascade do |t|
    t.string "name"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "thumbnail"
  end

  add_foreign_key "fixtures", "competitions"
  add_foreign_key "fixtures", "teams", column: "away_id"
  add_foreign_key "fixtures", "teams", column: "home_id"
  add_foreign_key "seasons", "teams"
  add_foreign_key "team_competitions", "teams"
end
