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

ActiveRecord::Schema[7.1].define(version: 2024_08_23_013409) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "clients_id", null: false
    t.string "account_number"
    t.decimal "current_value"
    t.date "opening_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clients_id"], name: "index_accounts_on_clients_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "string"
    t.string "password"
    t.date "birth_date"
    t.integer "doc_type"
    t.integer "doc_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string "transaction_type"
    t.decimal "value"
    t.datetime "transaction_date"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "accounts", "clients", column: "clients_id"
end
