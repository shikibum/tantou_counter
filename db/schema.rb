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

ActiveRecord::Schema.define(version: 2019_06_04_135232) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaigns", force: :cascade do |t|
    t.string "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "katanas", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "furigana"
    t.integer "katana_type"
    t.integer "tantou_time"
    t.boolean "forgeable", default: true, null: false
    t.boolean "rare", default: false, null: false
  end

  create_table "tantous", force: :cascade do |t|
    t.integer "kinji_id"
    t.integer "mokutan"
    t.integer "tamahagane"
    t.integer "reikyakuzai"
    t.integer "toishi"
    t.string "fuda"
    t.integer "katana_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "campaign_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "share_id"
  end

end
