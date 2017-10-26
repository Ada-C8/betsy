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

ActiveRecord::Schema.define(version: 20171025214645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_products", force: :cascade do |t|
    t.integer "category_id"
    t.integer "product_id"
  end

  create_table "merchants", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "oauth_provider", null: false
    t.string "oauth_uid", null: false
  end

  create_table "order_products", force: :cascade do |t|
    t.string "status"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_id"
    t.integer "product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "cust_name"
    t.string "status"
    t.string "cust_email"
    t.string "cust_cc"
    t.string "cust_cc_exp"
    t.string "cust_addr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "merchant_id"
    t.string "cvv"
    t.string "zip_code"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "image_url"
    t.float "price"
    t.integer "quantity"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "merchant_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "merchant_id"
    t.integer "product_id"
  end

end
