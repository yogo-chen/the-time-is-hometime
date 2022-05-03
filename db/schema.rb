# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_05_03_042923) do
  create_table "guests", id: { type: :integer, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", null: false
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_guests_on_email", unique: true
  end

  create_table "reservations", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", force: :cascade do |t|
    t.integer "guest_id", unsigned: true
    t.string "code", null: false
    t.string "status"
    t.integer "nights", limit: 2, unsigned: true
    t.integer "adults", limit: 1, unsigned: true
    t.integer "children", limit: 1, unsigned: true
    t.integer "infants", limit: 1, unsigned: true
    t.integer "total_guests", limit: 1, unsigned: true
    t.string "currency"
    t.decimal "payout_price", precision: 10, scale: 2
    t.decimal "security_price", precision: 10, scale: 2
    t.decimal "total_price", precision: 10, scale: 2
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_reservations_on_code", unique: true
    t.index ["guest_id"], name: "index_reservations_on_guest_id"
  end

end
