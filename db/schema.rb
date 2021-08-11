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

ActiveRecord::Schema.define(version: 2021_08_09_023402) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.text "first_name_ciphertext"
    t.text "last_name_ciphertext"
    t.text "email_ciphertext"
    t.text "state_ciphertext"
    t.text "age_ciphertext"
    t.text "first_name_bidx"
    t.text "last_name_bidx"
    t.text "email_bidx"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email_bidx"], name: "index_users_on_email_bidx", unique: true
    t.index ["first_name_bidx"], name: "index_users_on_first_name_bidx"
    t.index ["last_name_bidx"], name: "index_users_on_last_name_bidx"
  end

end
