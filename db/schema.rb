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

ActiveRecord::Schema.define(version: 20131004134411) do

  create_table "area_groups", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_details", force: true do |t|
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "address_line_3"
    t.string   "town"
    t.string   "county"
    t.string   "postcode"
    t.string   "country"
    t.string   "telephone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "member_id"
  end

  add_index "contact_details", ["member_id"], name: "index_contact_details_on_member_id", using: :btree

  create_table "entitlement_periods", force: true do |t|
    t.integer  "member_id"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "payment_id"
  end

  add_index "entitlement_periods", ["member_id"], name: "index_entitlement_periods_on_member_id", using: :btree
  add_index "entitlement_periods", ["payment_id"], name: "index_entitlement_periods_on_payment_id", using: :btree

  create_table "forum_details", force: true do |t|
    t.integer  "forum_id"
    t.string   "forum_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "member_id"
    t.string   "forum_password"
    t.string   "remember_token"
  end

  add_index "forum_details", ["member_id"], name: "index_forum_details_on_member_id", using: :btree
  add_index "forum_details", ["remember_token"], name: "index_forum_details_on_remember_token", using: :btree

  create_table "member_categories", force: true do |t|
    t.string   "description"
    t.integer  "price_in_pence_per_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.string   "forename"
    t.string   "surname"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "member_category_id"
    t.integer  "membership_status_id"
    t.integer  "source_channel_id"
    t.string   "signup_source"
    t.integer  "membership_number"
    t.date     "date_of_birth"
    t.date     "date_added"
    t.integer  "area_group_id"
    t.integer  "area_group_coordinator_id"
  end

  add_index "members", ["area_group_coordinator_id"], name: "index_members_on_area_group_coordinator_id", using: :btree
  add_index "members", ["area_group_id"], name: "index_members_on_area_group_id", using: :btree
  add_index "members", ["member_category_id"], name: "index_members_on_member_category_id", using: :btree
  add_index "members", ["membership_status_id"], name: "index_members_on_membership_status_id", using: :btree
  add_index "members", ["source_channel_id"], name: "index_members_on_source_channel_id", using: :btree

  create_table "membership_statuses", force: true do |t|
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_methods", force: true do |t|
    t.string   "payment_method"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.date     "payment_date"
    t.integer  "amount_in_pence"
    t.integer  "payable_id"
    t.string   "payable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "payment_method_id"
  end

  add_index "payments", ["payment_method_id"], name: "index_payments_on_payment_method_id", using: :btree

  create_table "source_channels", force: true do |t|
    t.string   "channel"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", force: true do |t|
    t.string   "go_cardless_reference"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "member_id"
  end

  add_index "subscriptions", ["member_id"], name: "index_subscriptions_on_member_id", using: :btree

end
