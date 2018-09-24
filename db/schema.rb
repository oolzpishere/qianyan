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

ActiveRecord::Schema.define(version: 2018_09_23_081026) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "english_dvds", force: :cascade do |t|
    t.string "openid"
    t.string "unionid"
    t.string "form"
    t.string "form_name"
    t.json "entry"
    t.string "gen_code"
    t.string "data_type"
    t.datetime "form_created_at"
    t.datetime "form_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_type"], name: "index_english_dvds_on_data_type"
    t.index ["form"], name: "index_english_dvds_on_form"
    t.index ["gen_code"], name: "index_english_dvds_on_gen_code"
    t.index ["openid"], name: "index_english_dvds_on_openid"
    t.index ["unionid"], name: "index_english_dvds_on_unionid"
  end

end
