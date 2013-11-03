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

ActiveRecord::Schema.define(version: 20131101173621) do

  create_table "area_groups", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cms_blocks", force: true do |t|
    t.integer  "page_id",                     null: false
    t.string   "identifier",                  null: false
    t.text     "content",    limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_blocks", ["page_id", "identifier"], name: "index_cms_blocks_on_page_id_and_identifier", using: :btree

  create_table "cms_categories", force: true do |t|
    t.integer "site_id",          null: false
    t.string  "label",            null: false
    t.string  "categorized_type", null: false
  end

  add_index "cms_categories", ["site_id", "categorized_type", "label"], name: "index_cms_categories_on_site_id_and_categorized_type_and_label", unique: true, using: :btree

  create_table "cms_categorizations", force: true do |t|
    t.integer "category_id",      null: false
    t.string  "categorized_type", null: false
    t.integer "categorized_id",   null: false
  end

  add_index "cms_categorizations", ["category_id", "categorized_type", "categorized_id"], name: "index_cms_categorizations_on_cat_id_and_catd_type_and_catd_id", unique: true, using: :btree

  create_table "cms_files", force: true do |t|
    t.integer  "site_id",                                    null: false
    t.integer  "block_id"
    t.string   "label",                                      null: false
    t.string   "file_file_name",                             null: false
    t.string   "file_content_type",                          null: false
    t.integer  "file_file_size",                             null: false
    t.string   "description",       limit: 2048
    t.integer  "position",                       default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_files", ["site_id", "block_id"], name: "index_cms_files_on_site_id_and_block_id", using: :btree
  add_index "cms_files", ["site_id", "file_file_name"], name: "index_cms_files_on_site_id_and_file_file_name", using: :btree
  add_index "cms_files", ["site_id", "label"], name: "index_cms_files_on_site_id_and_label", using: :btree
  add_index "cms_files", ["site_id", "position"], name: "index_cms_files_on_site_id_and_position", using: :btree

  create_table "cms_layouts", force: true do |t|
    t.integer  "site_id",                                     null: false
    t.integer  "parent_id"
    t.string   "app_layout"
    t.string   "label",                                       null: false
    t.string   "identifier",                                  null: false
    t.text     "content",    limit: 16777215
    t.text     "css",        limit: 16777215
    t.text     "js",         limit: 16777215
    t.integer  "position",                    default: 0,     null: false
    t.boolean  "is_shared",                   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_layouts", ["parent_id", "position"], name: "index_cms_layouts_on_parent_id_and_position", using: :btree
  add_index "cms_layouts", ["site_id", "identifier"], name: "index_cms_layouts_on_site_id_and_identifier", unique: true, using: :btree

  create_table "cms_pages", force: true do |t|
    t.integer  "site_id",                                         null: false
    t.integer  "layout_id"
    t.integer  "parent_id"
    t.integer  "target_page_id"
    t.string   "label",                                           null: false
    t.string   "slug"
    t.string   "full_path",                                       null: false
    t.text     "content",        limit: 16777215
    t.integer  "position",                        default: 0,     null: false
    t.integer  "children_count",                  default: 0,     null: false
    t.boolean  "is_published",                    default: true,  null: false
    t.boolean  "is_shared",                       default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_pages", ["parent_id", "position"], name: "index_cms_pages_on_parent_id_and_position", using: :btree
  add_index "cms_pages", ["site_id", "full_path"], name: "index_cms_pages_on_site_id_and_full_path", using: :btree

  create_table "cms_revisions", force: true do |t|
    t.string   "record_type",                  null: false
    t.integer  "record_id",                    null: false
    t.text     "data",        limit: 16777215
    t.datetime "created_at"
  end

  add_index "cms_revisions", ["record_type", "record_id", "created_at"], name: "index_cms_revisions_on_rtype_and_rid_and_created_at", using: :btree

  create_table "cms_sites", force: true do |t|
    t.string  "label",                       null: false
    t.string  "identifier",                  null: false
    t.string  "hostname",                    null: false
    t.string  "path"
    t.string  "locale",      default: "en",  null: false
    t.boolean "is_mirrored", default: false, null: false
  end

  add_index "cms_sites", ["hostname"], name: "index_cms_sites_on_hostname", using: :btree
  add_index "cms_sites", ["is_mirrored"], name: "index_cms_sites_on_is_mirrored", using: :btree

  create_table "cms_snippets", force: true do |t|
    t.integer  "site_id",                                     null: false
    t.string   "label",                                       null: false
    t.string   "identifier",                                  null: false
    t.text     "content",    limit: 16777215
    t.integer  "position",                    default: 0,     null: false
    t.boolean  "is_shared",                   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cms_snippets", ["site_id", "identifier"], name: "index_cms_snippets_on_site_id_and_identifier", unique: true, using: :btree
  add_index "cms_snippets", ["site_id", "position"], name: "index_cms_snippets_on_site_id_and_position", using: :btree

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
  end

  add_index "entitlement_periods", ["member_id"], name: "index_entitlement_periods_on_member_id", using: :btree

  create_table "forum_details", force: true do |t|
    t.integer  "forum_id"
    t.string   "forum_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "member_id"
    t.string   "forum_password"
    t.string   "remember_token"
    t.integer  "role_id"
  end

  add_index "forum_details", ["member_id"], name: "index_forum_details_on_member_id", using: :btree
  add_index "forum_details", ["remember_token"], name: "index_forum_details_on_remember_token", using: :btree
  add_index "forum_details", ["role_id"], name: "index_forum_details_on_role_id", using: :btree

  create_table "go_cardless_payment_methods", force: true do |t|
    t.string   "go_cardless_reference"
    t.integer  "payment_methodable_id"
    t.string   "payment_methodable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "payment_statuses", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_types", force: true do |t|
    t.string   "description"
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
    t.integer  "payment_type_id"
    t.integer  "payment_status_id"
    t.integer  "member_id"
    t.string   "go_cardless_reference"
  end

  add_index "payments", ["member_id"], name: "index_payments_on_member_id", using: :btree
  add_index "payments", ["payment_status_id"], name: "index_payments_on_payment_status_id", using: :btree
  add_index "payments", ["payment_type_id"], name: "index_payments_on_payment_type_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "source_channels", force: true do |t|
    t.string   "channel"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscription_renewal_types", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "member_id"
    t.integer  "subscription_renewal_type_id"
  end

  add_index "subscriptions", ["member_id"], name: "index_subscriptions_on_member_id", using: :btree
  add_index "subscriptions", ["subscription_renewal_type_id"], name: "index_subscriptions_on_subscription_renewal_type_id", using: :btree

end
