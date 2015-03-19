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

ActiveRecord::Schema.define(version: 20150317201723) do

  create_table "creditcards", force: true do |t|
    t.string   "name"
    t.string   "issuer"
    t.integer  "annual_fee"
    t.boolean  "fee_waived_first_year"
    t.string   "points_program"
    t.integer  "spend_bonus"
    t.integer  "spend_requirement"
    t.integer  "time_to_reach_spend_in_months"
    t.integer  "first_purchase_bonus"
    t.integer  "second_year_spend_bonus"
    t.integer  "second_year_spend_requirement"
    t.integer  "second_year_time_to_reach_spend_in_months"
    t.decimal  "points_per_dollar_spent_general_spend"
    t.decimal  "foreign_transaction_fee"
    t.string   "chip"
    t.text     "notes"
    t.boolean  "business"
    t.boolean  "personal"
    t.integer  "image_index"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
  end

  create_table "rates", force: true do |t|
    t.string   "transferringprogram"
    t.string   "transfereeprogram"
    t.decimal  "transferratio"
    t.text     "transfernotes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transfer_rates", force: true do |t|
    t.string   "transferringprogram"
    t.string   "transfereeprogram"
    t.decimal  "transferratio"
    t.text     "transfernotes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trips", force: true do |t|
    t.string   "name"
    t.decimal  "costinusd"
    t.integer  "aacostpts"
    t.decimal  "aacostusd"
    t.integer  "bacostpts"
    t.decimal  "bacostusd"
    t.integer  "uacostpts"
    t.decimal  "uacostusd"
    t.integer  "dlcostpts"
    t.decimal  "dlcostusd"
    t.integer  "ascostpts"
    t.decimal  "ascostusd"
    t.integer  "nkcostpts"
    t.decimal  "nkcostusd"
    t.integer  "sqcostpts"
    t.decimal  "sqcostusd"
    t.integer  "lacostpts"
    t.decimal  "lacostusd"
    t.integer  "accostpts"
    t.decimal  "accostusd"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
