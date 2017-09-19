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

ActiveRecord::Schema.define(version: 20170919005417) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "units_count", default: 0
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "admin_user_id"
  end

  create_table "active_admin_comments", id: :serial, force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_id", null: false
    t.string "resource_type", null: false
    t.integer "author_id"
    t.string "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "charges", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "frequency"
    t.integer "amount_in_cents"
    t.string "amount_currency"
    t.integer "lease_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leases", id: :serial, force: :cascade do |t|
    t.date "starts_on"
    t.integer "length_in_months", default: 12, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "unit_id"
    t.date "ends_on"
    t.string "preferred_payment_method"
    t.integer "admin_user_id"
    t.integer "rent_due", default: 1
    t.integer "grace_period_in_days", default: 1
  end

  create_table "payments", id: :serial, force: :cascade do |t|
    t.integer "lease_id"
    t.string "name"
    t.integer "amount_due_in_cents", default: 0, null: false
    t.string "amount_due_currency", default: "USD", null: false
    t.integer "amount_collected_in_cents", default: 0, null: false
    t.string "amount_collected_currency", default: "USD", null: false
    t.date "collected_on"
    t.date "deposited_on"
    t.string "received_via"
    t.integer "admin_user_id"
    t.date "applicable_period"
    t.integer "charge_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_user_id"], name: "index_payments_on_admin_user_id"
    t.index ["charge_id"], name: "index_payments_on_charge_id"
    t.index ["lease_id"], name: "index_payments_on_lease_id"
  end

  create_table "properties", id: :serial, force: :cascade do |t|
    t.string "tax_number"
    t.integer "units_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_id"
    t.boolean "is_rental_unit", default: false
    t.integer "unit_type_id"
    t.integer "rent_due", default: 1
    t.string "latitude"
    t.string "longitude"
    t.string "location"
    t.string "location_type"
    t.string "formatted_address"
    t.string "bounds"
    t.string "viewport"
    t.string "route"
    t.string "street_number"
    t.string "postal_code"
    t.string "locality"
    t.string "sublocality"
    t.string "country"
    t.string "country_short"
    t.string "administrative_area_level_1"
    t.string "administrative_area_level_2"
    t.string "place_id"
    t.string "reference"
    t.string "url"
    t.string "name"
    t.integer "admin_user_id"
  end

  create_table "rents", id: :serial, force: :cascade do |t|
    t.integer "amount_due_in_cents"
    t.integer "amount_collected_in_cents"
    t.string "month"
    t.datetime "collected_at"
    t.datetime "deposited_at"
    t.string "received_via"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lease_id"
    t.integer "admin_user_id"
    t.date "applicable_period"
    t.index ["lease_id"], name: "index_rents_on_lease_id"
  end

  create_table "tenants", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "mobile"
    t.string "work_phone"
    t.string "home_phone"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "signee", default: false
    t.boolean "primary", default: false
    t.integer "admin_user_id"
  end

  create_table "terms", id: :serial, force: :cascade do |t|
    t.integer "lease_id"
    t.integer "tenant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "unit_types", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", id: :serial, force: :cascade do |t|
    t.string "number"
    t.string "dimension"
    t.text "notes"
    t.integer "issues_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "property_id"
    t.integer "unit_type_id"
    t.string "latitude"
    t.string "longitude"
    t.string "location"
    t.string "location_type"
    t.string "formatted_address"
    t.string "bounds"
    t.string "viewport"
    t.string "route"
    t.string "street_number"
    t.string "postal_code"
    t.string "locality"
    t.string "sublocality"
    t.string "country"
    t.string "country_short"
    t.string "administrative_area_level_1"
    t.string "administrative_area_level_2"
    t.string "place_id"
    t.string "reference"
    t.string "url"
    t.string "name"
    t.integer "admin_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.integer "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "admin_user_id"
  end

  add_foreign_key "payments", "admin_users"
  add_foreign_key "payments", "charges"
  add_foreign_key "payments", "leases"
end
