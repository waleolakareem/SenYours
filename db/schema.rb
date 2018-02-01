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

ActiveRecord::Schema.define(version: 20180201053743) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.integer "senior_id"
    t.integer "companion_id"
    t.time "start_time"
    t.time "end_time"
    t.date "start_date"
    t.date "end_date"
    t.integer "fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accept"
    t.string "payment_status"
  end

  create_table "available_days", force: :cascade do |t|
    t.integer "user_id"
    t.text "comment"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "available_times", force: :cascade do |t|
    t.integer "available_day_id"
    t.text "comment"
    t.time "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.bigint "conversation_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "sender_read", default: false, null: false
    t.boolean "recipient_read", default: false, null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "comment"
    t.integer "reviewer_id"
    t.integer "user_id"
    t.integer "wyr_rating"
    t.integer "comm_rating"
    t.integer "comp_rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.bigint "phone_number"
    t.string "password_digest"
    t.integer "zipcode"
    t.string "state"
    t.string "city"
    t.string "address"
    t.string "encrypted_ssn"
    t.string "encrypted_ssn_iv"
    t.integer "fee"
    t.text "description"
    t.string "avatar"
    t.string "verification_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "availability"
    t.string "identification"
    t.integer "age"
    t.string "age_range"
    t.string "stripe_customer_id"
    t.date "dob"
    t.string "accurate_customer_id"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
