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

ActiveRecord::Schema.define(version: 20170724203621) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contractors", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "status"
    t.boolean "true"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "merchants", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "merchant_id"
    t.bigint "contractor_id"
    t.string "destination"
    t.datetime "claim_time"
    t.datetime "pick_up_time"
    t.datetime "delivery_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contractor_id"], name: "index_orders_on_contractor_id"
    t.index ["merchant_id"], name: "index_orders_on_merchant_id"
  end

  add_foreign_key "orders", "contractors"
  add_foreign_key "orders", "merchants"
end
