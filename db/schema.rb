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

ActiveRecord::Schema.define(version: 20160103221000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accommodations", force: :cascade do |t|
    t.string   "name",                             null: false
    t.integer  "sleeps"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "price_pence",          default: 0, null: false
    t.integer  "initial_availability"
  end

  create_table "basket_items", force: :cascade do |t|
    t.integer  "product_id",   null: false
    t.string   "product_type", null: false
    t.integer  "quantity",     null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "basket_items", ["product_type", "product_id"], name: "index_basket_items_on_product_type_and_product_id", using: :btree

  create_table "baskets", force: :cascade do |t|
    t.integer  "invite_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "baskets", ["invite_id"], name: "index_baskets_on_invite_id", using: :btree

  create_table "guests", force: :cascade do |t|
    t.string   "name",                   null: false
    t.integer  "invite_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "attendance"
    t.string   "diet"
    t.string   "attendance_restriction"
    t.string   "email_address"
  end

  add_index "guests", ["invite_id"], name: "index_guests_on_invite_id", using: :btree

  create_table "invites", force: :cascade do |t|
    t.string   "invite_code", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "invites", ["invite_code"], name: "index_invites_on_invite_code", unique: true, using: :btree

  add_foreign_key "baskets", "invites"
  add_foreign_key "guests", "invites"
end
