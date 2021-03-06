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

ActiveRecord::Schema.define(version: 20151217191013) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apartments", force: :cascade do |t|
    t.string   "unit"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "building_id"
  end

  add_index "apartments", ["building_id"], name: "index_apartments_on_building_id", using: :btree

  create_table "api_keys", force: :cascade do |t|
    t.string   "access_token"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "buildings", force: :cascade do |t|
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "buildings", ["address_1", "address_2", "city", "state", "country", "zip_code"], name: "unique_address", unique: true, using: :btree

  create_table "notifications", force: :cascade do |t|
    t.string   "notification_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "person_id",         null: false
    t.integer  "apartment_id"
  end

  add_index "notifications", ["person_id"], name: "index_notifications_on_person_id", using: :btree

  create_table "occupants", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "apartment_id"
    t.integer  "person_id"
  end

  create_table "people", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
