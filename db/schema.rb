ActiveRecord::Schema.define(version: 2021_04_11_154853) do

  create_table "reservations", force: :cascade do |t|
    t.date "date"
    t.time "checkin"
    t.time "checkout"
    t.integer "venue_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.time "opening_hour"
    t.time "closing_hour"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
