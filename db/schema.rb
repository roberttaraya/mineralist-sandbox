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

ActiveRecord::Schema.define(version: 20141114161931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "permits", force: true do |t|
    t.integer  "file_number"
    t.integer  "api_number",       limit: 8
    t.string   "operator_name"
    t.integer  "township"
    t.string   "township_bearing"
    t.integer  "range"
    t.string   "range_bearing"
    t.integer  "section"
    t.string   "state"
    t.string   "field_name"
    t.date     "effective_on"
    t.string   "action_type"
    t.string   "slant"
    t.string   "target_formation"
    t.integer  "elevation"
    t.integer  "depth"
    t.integer  "countyfips"
    t.string   "well_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "productions", force: true do |t|
    t.integer  "api_number",     limit: 8
    t.date     "reported_on"
    t.decimal  "barrels_oil"
    t.decimal  "mcf_gas"
    t.decimal  "barrels_water"
    t.integer  "days_producing"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
