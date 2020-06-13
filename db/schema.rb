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

ActiveRecord::Schema.define(version: 2020_03_20_065246) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "bid_descriptions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.bigint "bid_id"
    t.bigint "description_id"
    t.index ["bid_id"], name: "index_bid_descriptions_on_bid_id"
    t.index ["description_id"], name: "index_bid_descriptions_on_description_id"
  end

  create_table "bid_likes", force: :cascade do |t|
    t.integer "like", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "bid_id"
    t.index ["bid_id"], name: "index_bid_likes_on_bid_id"
    t.index ["user_id"], name: "index_bid_likes_on_user_id"
  end

  create_table "bids", force: :cascade do |t|
    t.integer "status", default: 0
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "item_id"
    t.decimal "amount", precision: 10, scale: 2, default: "0.0", null: false
    t.string "name", default: "", null: false
    t.integer "vote_count", default: 0, null: false
    t.index ["item_id"], name: "index_bids_on_item_id"
    t.index ["user_id"], name: "index_bids_on_user_id"
  end

  create_table "descriptions", force: :cascade do |t|
    t.string "label", null: false
    t.string "detail", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_buyings", force: :cascade do |t|
    t.integer "quantity", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "item_id"
    t.index ["item_id"], name: "index_group_buyings_on_item_id"
    t.index ["user_id"], name: "index_group_buyings_on_user_id"
  end

  create_table "group_users", force: :cascade do |t|
    t.integer "user_type", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "group_id"
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invites", force: :cascade do |t|
    t.string "email", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_invites_on_user_id"
  end

  create_table "item_descriptions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "item_id"
    t.bigint "description_id"
    t.index ["description_id"], name: "index_item_descriptions_on_description_id"
    t.index ["item_id"], name: "index_item_descriptions_on_item_id"
  end

  create_table "item_groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "item_id"
    t.bigint "group_id"
    t.index ["group_id"], name: "index_item_groups_on_group_id"
    t.index ["item_id"], name: "index_item_groups_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.decimal "max_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "status", null: false
    t.datetime "bidding_end_time", null: false
    t.integer "winner_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "group_buying", default: 0
    t.integer "quantity", default: 0
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "tokens", force: :cascade do |t|
    t.string "token", null: false
    t.datetime "last_used_on", null: false
    t.datetime "created_at", null: false
    t.bigint "user_id"
    t.index ["token"], name: "index_tokens_on_token", unique: true
    t.index ["user_id"], name: "index_tokens_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "transaction_type", null: false
    t.integer "status", default: 0
    t.integer "amount", default: 0, null: false
    t.integer "paid_amount", default: 0
    t.string "transaction_id"
    t.string "token", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "bid_id"
    t.index ["bid_id"], name: "index_transactions_on_bid_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "mobile_number", limit: 10, null: false
    t.text "address", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.integer "type_of_user", default: 0, null: false
    t.integer "invite_count", default: 0, null: false
    t.date "last_invite_at", default: "1900-01-01"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "last_sign_in"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "customer_id", default: ""
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["mobile_number"], name: "index_users_on_mobile_number", unique: true
  end

  create_table "verifications", force: :cascade do |t|
    t.string "email", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token", null: false
    t.index ["email"], name: "index_verifications_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bid_descriptions", "bids"
  add_foreign_key "bid_descriptions", "descriptions"
  add_foreign_key "bid_likes", "bids"
  add_foreign_key "bid_likes", "users"
  add_foreign_key "bids", "items"
  add_foreign_key "bids", "users"
  add_foreign_key "group_buyings", "items"
  add_foreign_key "group_buyings", "users"
  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
  add_foreign_key "invites", "users"
  add_foreign_key "item_descriptions", "descriptions"
  add_foreign_key "item_descriptions", "items"
  add_foreign_key "item_groups", "groups"
  add_foreign_key "item_groups", "items"
  add_foreign_key "items", "users"
  add_foreign_key "tokens", "users"
  add_foreign_key "transactions", "bids"
  add_foreign_key "transactions", "users"
end
