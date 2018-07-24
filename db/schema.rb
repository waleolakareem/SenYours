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

ActiveRecord::Schema.define(version: 20180606202119) do

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
    t.index ["date"], name: "index_available_days_on_date"
  end

  create_table "available_times", force: :cascade do |t|
    t.integer "available_day_id"
    t.text "comment"
    t.time "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["time"], name: "index_available_times_on_time"
  end

  create_table "blogs", force: :cascade do |t|
    t.string "title"
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "join_users_tasks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "task_id"
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

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.integer "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone_number"
    t.string "password_digest"
    t.integer "zipcode"
    t.string "state"
    t.string "city"
    t.string "address"
    t.integer "fee"
    t.text "description"
    t.string "avatar"
    t.string "verification_image"
    t.string "services_selected"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "availability"
    t.string "identification"
    t.integer "age"
    t.string "age_range"
    t.string "stripe_customer_id"
    t.date "dob"
    t.string "accurate_customer_id"
    t.string "terms_of_service"
    t.string "privacy_policy"
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "assessment", default: "no"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
