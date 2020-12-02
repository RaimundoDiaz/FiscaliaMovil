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

ActiveRecord::Schema.define(version: 2020_12_02_191513) do

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
    t.boolean "deleted", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "local_prosecutions", force: :cascade do |t|
    t.string "name"
    t.bigint "regional_prosecution_id", null: false
    t.boolean "deleted", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["regional_prosecution_id"], name: "index_local_prosecutions_on_regional_prosecution_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "procedure_id"
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["procedure_id"], name: "index_messages_on_procedure_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "notification_type"
    t.integer "reference_id"
    t.boolean "seen"
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
    t.boolean "deceased"
    t.string "contact"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "person_in_procedures", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "procedure_id", null: false
    t.string "witness_declaration"
    t.integer "role"
    t.integer "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_person_in_procedures_on_person_id"
    t.index ["procedure_id"], name: "index_person_in_procedures_on_procedure_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string "description"
    t.bigint "procedure_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["procedure_id"], name: "index_photos_on_procedure_id"
  end

  create_table "police_men", force: :cascade do |t|
    t.string "name"
    t.string "rut"
    t.integer "badge"
    t.string "phone_number"
    t.boolean "deleted", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "police_stations", force: :cascade do |t|
    t.string "name"
    t.integer "police_type"
    t.bigint "prefecture_id", null: false
    t.boolean "deleted", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["prefecture_id"], name: "index_police_stations_on_prefecture_id"
  end

  create_table "police_units", force: :cascade do |t|
    t.string "name"
    t.bigint "police_station_id", null: false
    t.bigint "local_prosecution_id", null: false
    t.boolean "deleted", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["local_prosecution_id"], name: "index_police_units_on_local_prosecution_id"
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
    t.bigint "police_in_charge_id", null: false
    t.bigint "police_unit_in_charge_id", null: false
    t.bigint "prosecutor_in_charge_id", null: false
    t.bigint "local_prosecution_in_charge_id", null: false
    t.bigint "creator_id", null: false
    t.string "story", null: false
    t.string "address"
    t.string "sector"
    t.string "region"
    t.integer "state"
    t.datetime "date_of_arrest"
    t.boolean "involves_deceased"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_procedures_on_creator_id"
    t.index ["local_prosecution_in_charge_id"], name: "index_procedures_on_local_prosecution_in_charge_id"
    t.index ["police_in_charge_id"], name: "index_procedures_on_police_in_charge_id"
    t.index ["police_unit_in_charge_id"], name: "index_procedures_on_police_unit_in_charge_id"
    t.index ["prosecutor_in_charge_id"], name: "index_procedures_on_prosecutor_in_charge_id"
  end

  create_table "prosecutors", force: :cascade do |t|
    t.string "name"
    t.string "rut"
    t.boolean "prosecutor_on_duty", default: true
    t.bigint "local_prosecution_id"
    t.boolean "deleted", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["local_prosecution_id"], name: "index_prosecutors_on_local_prosecution_id"
  end

  create_table "regional_prosecutions", force: :cascade do |t|
    t.string "name"
    t.integer "region"
    t.boolean "deleted", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "registry_in_accuseds", force: :cascade do |t|
    t.bigint "accused_id", null: false
    t.bigint "prosecutor_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["accused_id"], name: "index_registry_in_accuseds_on_accused_id"
    t.index ["prosecutor_id"], name: "index_registry_in_accuseds_on_prosecutor_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id"
    t.bigint "procedure_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["procedure_id"], name: "index_taggings_on_procedure_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.boolean "deleted", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.bigint "police_unit_id"
    t.bigint "prosecutor_id"
    t.bigint "local_prosecution_id"
    t.boolean "deleted", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["local_prosecution_id"], name: "index_users_on_local_prosecution_id"
    t.index ["police_unit_id"], name: "index_users_on_police_unit_id"
    t.index ["prosecutor_id"], name: "index_users_on_prosecutor_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "description"
    t.bigint "procedure_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["procedure_id"], name: "index_videos_on_procedure_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "alias_accuseds", "people"
  add_foreign_key "crime_in_accuseds", "crimes"
  add_foreign_key "crime_in_accuseds", "people"
  add_foreign_key "crime_in_accuseds", "procedures"
  add_foreign_key "local_prosecutions", "regional_prosecutions"
  add_foreign_key "notifications", "users"
  add_foreign_key "person_in_procedures", "people"
  add_foreign_key "person_in_procedures", "procedures"
  add_foreign_key "police_stations", "prefectures"
  add_foreign_key "police_units", "local_prosecutions"
  add_foreign_key "police_units", "police_stations"
  add_foreign_key "procedures", "local_prosecutions", column: "local_prosecution_in_charge_id"
  add_foreign_key "procedures", "police_men", column: "police_in_charge_id"
  add_foreign_key "procedures", "police_units", column: "police_unit_in_charge_id"
  add_foreign_key "procedures", "prosecutors", column: "prosecutor_in_charge_id"
  add_foreign_key "procedures", "users", column: "creator_id"
  add_foreign_key "prosecutors", "local_prosecutions"
  add_foreign_key "registry_in_accuseds", "person_in_procedures", column: "accused_id"
  add_foreign_key "registry_in_accuseds", "prosecutors"
  add_foreign_key "taggings", "procedures"
  add_foreign_key "taggings", "tags"
  add_foreign_key "users", "local_prosecutions"
  add_foreign_key "users", "police_units"
  add_foreign_key "users", "prosecutors"
end
