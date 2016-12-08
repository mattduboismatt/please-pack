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

ActiveRecord::Schema.define(version: 20161208225425) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contestant_scores", force: :cascade do |t|
    t.integer  "contestant_id", null: false
    t.integer  "score_id",      null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["contestant_id"], name: "index_contestant_scores_on_contestant_id", using: :btree
    t.index ["score_id"], name: "index_contestant_scores_on_score_id", using: :btree
  end

  create_table "contestants", force: :cascade do |t|
    t.integer  "pool_id",     null: false
    t.string   "first_name",  null: false
    t.string   "last_name"
    t.string   "residence"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["pool_id"], name: "index_contestants_on_pool_id", using: :btree
  end

  create_table "entries", force: :cascade do |t|
    t.integer  "pool_id",                null: false
    t.string   "name",                   null: false
    t.integer  "points",     default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["pool_id"], name: "index_entries_on_pool_id", using: :btree
  end

  create_table "picks", force: :cascade do |t|
    t.integer  "entry_id",      null: false
    t.integer  "contestant_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["contestant_id"], name: "index_picks_on_contestant_id", using: :btree
    t.index ["entry_id"], name: "index_picks_on_entry_id", using: :btree
  end

  create_table "pools", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scores", force: :cascade do |t|
    t.integer  "points",     default: 1, null: false
    t.string   "mechanism",              null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
