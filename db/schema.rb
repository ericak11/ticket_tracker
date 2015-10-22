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

ActiveRecord::Schema.define(version: 20150924203327) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ticket_groups", force: :cascade do |t|
    t.string   "date"
    t.string   "time"
    t.string   "venue"
    t.string   "sport"
    t.text     "notes"
    t.string   "home_team"
    t.string   "away_team"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", force: :cascade do |t|
    t.string   "seat"
    t.string   "row"
    t.string   "section"
    t.decimal  "sale_price"
    t.string   "use_type"
    t.decimal  "face_value"
    t.integer  "ticket_group_id"
    t.text     "notes"
    t.string   "user"
    t.boolean  "sold"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
