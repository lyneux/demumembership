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

ActiveRecord::Schema.define(version: 20130922080119) do

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
    t.date     "endDate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entitlement_periods", ["member_id"], name: "index_entitlement_periods_on_member_id", using: :btree

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
  end

  add_index "members", ["member_category_id"], name: "index_members_on_member_category_id", using: :btree
  add_index "members", ["membership_status_id"], name: "index_members_on_membership_status_id", using: :btree
  add_index "members", ["source_channel_id"], name: "index_members_on_source_channel_id", using: :btree

  create_table "membership_statuses", force: true do |t|
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "source_channels", force: true do |t|
    t.string   "channel"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
