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

ActiveRecord::Schema.define(version: 20160726205039) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amounts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "resource_id"
    t.integer "quantity"
  end

  create_table "disasters", force: :cascade do |t|
    t.string "name"
  end

  create_table "resources", force: :cascade do |t|
    t.string  "name"
    t.float   "cost"
    t.boolean "incrementable"
    t.string  "unit"
    t.string  "item_type"
    t.integer "value"
    t.string  "blurb"
  end

  create_table "users", force: :cascade do |t|
    t.string  "name"
    t.float   "money"
    t.integer "high_score"
    t.string  "scenario_name"
    t.integer "food_count"
    t.integer "water_count"
    t.integer "medicine_count"
    t.integer "protection_count"
    t.boolean "alive"
  end

end
