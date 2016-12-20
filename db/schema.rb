# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20161220175121) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.integer  "units_count", default: 0
    t.boolean  "active",      default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "created_by"
    t.string   "updated_by"
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "created_by"
    t.string   "updated_by"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "leases", force: :cascade do |t|
    t.date     "starts_on"
    t.integer  "length_in_months",          default: 12,    null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "unit_id"
    t.string   "created_by"
    t.string   "updated_by"
    t.integer  "security_deposit_in_cents", default: 0,     null: false
    t.string   "security_deposit_currency", default: "USD", null: false
    t.integer  "monthly_rent_in_cents",     default: 0,     null: false
    t.string   "monthly_rent_currency",     default: "USD", null: false
    t.date     "ends_on"
    t.integer  "pet_fee_in_cents",          default: 0,     null: false
    t.string   "pet_fee_currency",          default: "USD", null: false
    t.string   "preferred_payment_method"
  end

  create_table "properties", force: :cascade do |t|
    t.string   "tax_number"
    t.integer  "units_count",                 default: 0
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "account_id"
    t.string   "created_by"
    t.string   "updated_by"
    t.boolean  "is_rental_unit",              default: false
    t.integer  "unit_type_id"
    t.integer  "rent_due",                    default: 1
    t.string   "latitude"
    t.string   "longitude"
    t.string   "location"
    t.string   "location_type"
    t.string   "formatted_address"
    t.string   "bounds"
    t.string   "viewport"
    t.string   "route"
    t.string   "street_number"
    t.string   "postal_code"
    t.string   "locality"
    t.string   "sublocality"
    t.string   "country"
    t.string   "country_short"
    t.string   "administrative_area_level_1"
    t.string   "administrative_area_level_2"
    t.string   "place_id"
    t.string   "reference"
    t.string   "url"
    t.string   "name"
  end

  create_table "rents", force: :cascade do |t|
    t.integer  "amount_due_in_cents"
    t.integer  "amount_collected_in_cents"
    t.string   "month"
    t.datetime "collected_at"
    t.datetime "deposited_at"
    t.string   "received_via"
    t.text     "notes"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "lease_id"
    t.integer  "user_id"
    t.datetime "applicable_period"
  end

  add_index "rents", ["lease_id"], name: "index_rents_on_lease_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.json     "unit_types"
    t.json     "default_charges"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "tenants", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "mobile"
    t.string   "work_phone"
    t.string   "home_phone"
    t.text     "notes"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "property_id"
    t.string   "created_by"
    t.string   "updated_by"
    t.boolean  "signee",      default: false
    t.boolean  "primary",     default: false
  end

  create_table "terms", force: :cascade do |t|
    t.integer  "lease_id"
    t.integer  "tenant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "unit_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.string   "number"
    t.string   "dimension"
    t.text     "notes"
    t.integer  "issues_count",                default: 0
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "property_id"
    t.integer  "unit_type_id"
    t.string   "created_by"
    t.string   "updated_by"
    t.integer  "rent_due",                    default: 1
    t.string   "latitude"
    t.string   "longitude"
    t.string   "location"
    t.string   "location_type"
    t.string   "formatted_address"
    t.string   "bounds"
    t.string   "viewport"
    t.string   "route"
    t.string   "street_number"
    t.string   "postal_code"
    t.string   "locality"
    t.string   "sublocality"
    t.string   "country"
    t.string   "country_short"
    t.string   "administrative_area_level_1"
    t.string   "administrative_area_level_2"
    t.string   "place_id"
    t.string   "reference"
    t.string   "url"
    t.string   "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "type"
    t.integer  "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "created_by"
    t.string   "updated_by"
  end

end
