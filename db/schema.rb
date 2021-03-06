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

ActiveRecord::Schema.define(version: 20160219235751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accommodations", force: :cascade do |t|
    t.string   "name",                             null: false
    t.integer  "sleeps"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "price_pence",          default: 0, null: false
    t.integer  "initial_availability"
    t.text     "description"
  end

  create_table "basket_items", force: :cascade do |t|
    t.integer  "product_id",   null: false
    t.string   "product_type", null: false
    t.integer  "quantity",     null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "basket_id",    null: false
  end

  add_index "basket_items", ["basket_id"], name: "index_basket_items_on_basket_id", using: :btree
  add_index "basket_items", ["product_type", "product_id"], name: "index_basket_items_on_product_type_and_product_id", using: :btree

  create_table "basket_transitions", force: :cascade do |t|
    t.string   "to_state",                   null: false
    t.text     "metadata",    default: "{}"
    t.integer  "sort_key",                   null: false
    t.integer  "basket_id",                  null: false
    t.boolean  "most_recent",                null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "basket_transitions", ["basket_id", "most_recent"], name: "index_basket_transitions_parent_most_recent", unique: true, where: "most_recent", using: :btree
  add_index "basket_transitions", ["basket_id", "sort_key"], name: "index_basket_transitions_parent_sort", unique: true, using: :btree

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
  end

  add_index "guests", ["invite_id"], name: "index_guests_on_invite_id", using: :btree

  create_table "invites", force: :cascade do |t|
    t.string   "invite_code",   null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "email_address"
    t.string   "name",          null: false
    t.text     "cabaret_info"
  end

  add_index "invites", ["invite_code"], name: "index_invites_on_invite_code", unique: true, using: :btree

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "order_charges", force: :cascade do |t|
    t.string   "stripe_charge_id"
    t.integer  "order_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "order_charges", ["order_id"], name: "index_order_charges_on_order_id", using: :btree

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id",                      null: false
    t.integer  "product_id",                    null: false
    t.string   "product_type",                  null: false
    t.integer  "sale_price_pence",  default: 0, null: false
    t.integer  "quantity",                      null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "total_price_pence", default: 0, null: false
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["product_type", "product_id"], name: "index_order_items_on_product_type_and_product_id", using: :btree

  create_table "order_transitions", force: :cascade do |t|
    t.string   "to_state",                   null: false
    t.text     "metadata",    default: "{}"
    t.integer  "sort_key",                   null: false
    t.integer  "order_id",                   null: false
    t.boolean  "most_recent",                null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "order_transitions", ["order_id", "most_recent"], name: "index_order_transitions_parent_most_recent", unique: true, where: "most_recent", using: :btree
  add_index "order_transitions", ["order_id", "sort_key"], name: "index_order_transitions_parent_sort", unique: true, using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "basket_id"
    t.string   "stripe_token"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "invite_id"
    t.integer  "total_price_pence", default: 0, null: false
  end

  add_index "orders", ["basket_id"], name: "index_orders_on_basket_id", using: :btree
  add_index "orders", ["invite_id"], name: "index_orders_on_invite_id", using: :btree

  add_foreign_key "basket_items", "baskets"
  add_foreign_key "baskets", "invites"
  add_foreign_key "guests", "invites"
  add_foreign_key "order_charges", "orders"
  add_foreign_key "orders", "baskets"
  add_foreign_key "orders", "invites"
end
