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

ActiveRecord::Schema.define(version: 20150429140040) do

  create_table "admins", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "password_digest", limit: 255
    t.string   "email",           limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "admins", ["name"], name: "index_admins_on_name", unique: true, using: :btree

  create_table "books", force: :cascade do |t|
    t.decimal  "isbn",                      precision: 13
    t.string   "category",      limit: 255
    t.string   "title",         limit: 255
    t.string   "publisher",     limit: 255
    t.decimal  "year",                      precision: 4
    t.string   "author",        limit: 255
    t.decimal  "price",                     precision: 7,  scale: 2
    t.integer  "total_storage", limit: 4
    t.integer  "storage",       limit: 4
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "books", ["isbn"], name: "index_books_on_isbn", unique: true, using: :btree
  add_index "books", ["title"], name: "index_books_on_title", using: :btree

  create_table "cards", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "dept",       limit: 255
    t.string   "card_type",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "records", force: :cascade do |t|
    t.integer  "book_id",      limit: 4
    t.integer  "card_id",      limit: 4
    t.integer  "admin_id",     limit: 4
    t.datetime "returned_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.datetime "to_return_at"
  end

  add_index "records", ["admin_id"], name: "index_records_on_admin_id", using: :btree
  add_index "records", ["book_id"], name: "index_records_on_book_id", using: :btree
  add_index "records", ["card_id"], name: "index_records_on_card_id", using: :btree

  add_foreign_key "records", "admins"
  add_foreign_key "records", "books"
  add_foreign_key "records", "cards"
end
