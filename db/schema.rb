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

ActiveRecord::Schema.define(version: 20150212171820) do

  create_table "accounts", force: true do |t|
    t.string   "account_number",   limit: 20,                 null: false
    t.string   "account_fidor_id", limit: 20,                 null: false
    t.string   "customer_id",      limit: 20,                 null: false
    t.boolean  "two_man_rule",                default: false, null: false
    t.boolean  "is_active",                   default: true,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "approver_id",      limit: 20, default: "1",   null: false
  end

  create_table "payments", force: true do |t|
    t.string   "transaction_number",     limit: 45,                null: false
    t.string   "amount",                 limit: 45,                null: false
    t.string   "currency",               limit: 45,                null: false
    t.string   "iban",                   limit: 45,                null: false
    t.string   "bic",                    limit: 45,                null: false
    t.string   "txt_reference",          limit: 140
    t.integer  "status_id",                                        null: false
    t.integer  "account_id",                                       null: false
    t.string   "txt_rejected_reference", limit: 140
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid",                   limit: 36,  default: "1", null: false
    t.string   "name",                   limit: 70
  end

  create_table "statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
