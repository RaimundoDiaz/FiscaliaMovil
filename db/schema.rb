# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_27_001751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alias_accuseds", force: :cascade do |t|
    t.string "alias"
    t.bigint "person_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_alias_accuseds_on_person_id"
  end

  create_table "crime_in_accuseds", force: :cascade do |t|
    t.boolean "preponderant"
    t.bigint "crime_id", null: false
    t.bigint "person_id", null: false
    t.bigint "procedure_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["crime_id"], name: "index_crime_in_accuseds_on_crime_id"
    t.index ["person_id"], name: "index_crime_in_accuseds_on_person_id"
    t.index ["procedure_id"], name: "index_crime_in_accuseds_on_procedure_id"
  end

  create_table "crimes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "local_prosecutions", force: :cascade do |t|
    t.string "name"
    t.bigint "regional_prosecution_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["regional_prosecution_id"], name: "index_local_prosecutions_on_regional_prosecution_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "sender_user_id", null: false
    t.bigint "receiver_user_id", null: false
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["receiver_user_id"], name: "index_messages_on_receiver_user_id"
    t.index ["sender_user_id"], name: "index_messages_on_sender_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "notification_type"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.date "birthday"
    t.string "rut"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "person_in_procedures", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "procedure_id", null: false
    t.integer "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_person_in_procedures_on_person_id"
    t.index ["procedure_id"], name: "index_person_in_procedures_on_procedure_id"
  end

  create_table "police_stations", force: :cascade do |t|
    t.string "name"
    t.integer "police_type"
    t.bigint "prefecture_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["prefecture_id"], name: "index_police_stations_on_prefecture_id"
  end

  create_table "police_units", force: :cascade do |t|
    t.string "name"
    t.bigint "police_station_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["police_station_id"], name: "index_police_units_on_police_station_id"
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "name"
    t.integer "region"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "procedures", force: :cascade do |t|
    t.integer "classification"
    t.text "categories", array: true
    t.bigint "police_in_charge_id", null: false
    t.bigint "local_prosecution_id", null: false
    t.string "story"
    t.string "address"
    t.integer "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["local_prosecution_id"], name: "index_procedures_on_local_prosecution_id"
    t.index ["police_in_charge_id"], name: "index_procedures_on_police_in_charge_id"
  end

  create_table "regional_prosecutions", force: :cascade do |t|
    t.string "name"
    t.integer "region"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer "role"
    t.string "rut"
    t.date "birthday"
    t.bigint "police_unit_id"
    t.bigint "local_prosecution_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["local_prosecution_id"], name: "index_users_on_local_prosecution_id"
    t.index ["police_unit_id"], name: "index_users_on_police_unit_id"
  end

  add_foreign_key "alias_accuseds", "people"
  add_foreign_key "crime_in_accuseds", "crimes"
  add_foreign_key "crime_in_accuseds", "people"
  add_foreign_key "crime_in_accuseds", "procedures"
  add_foreign_key "local_prosecutions", "regional_prosecutions"
  add_foreign_key "messages", "users", column: "receiver_user_id"
  add_foreign_key "messages", "users", column: "sender_user_id"
  add_foreign_key "notifications", "users"
  add_foreign_key "person_in_procedures", "people"
  add_foreign_key "person_in_procedures", "procedures"
  add_foreign_key "police_stations", "prefectures"
  add_foreign_key "police_units", "police_stations"
  add_foreign_key "procedures", "local_prosecutions"
  add_foreign_key "procedures", "users", column: "police_in_charge_id"
  add_foreign_key "users", "local_prosecutions"
  add_foreign_key "users", "police_units"
end
