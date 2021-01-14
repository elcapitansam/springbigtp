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

ActiveRecord::Schema.define(version: 2021_01_14_172725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "identifiers", force: :cascade do |t|
    t.string "identifier"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "record_errors", force: :cascade do |t|
    t.string "text"
    t.bigint "identifier_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "row"
    t.index ["identifier_id"], name: "index_record_errors_on_identifier_id"
  end

  create_table "records", force: :cascade do |t|
    t.integer "row"
    t.string "first"
    t.string "last"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", precision: 6, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "now()" }, null: false
    t.bigint "identifier_id"
    t.index ["identifier_id"], name: "index_records_on_identifier_id"
  end

  add_foreign_key "record_errors", "identifiers"
  add_foreign_key "records", "identifiers"
end
