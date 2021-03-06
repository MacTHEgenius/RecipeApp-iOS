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

ActiveRecord::Schema.define(version: 20170119011338) do

  create_table "authors", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "auth_token",             default: ""
  end

  add_index "authors", ["auth_token"], name: "index_authors_on_auth_token", unique: true
  add_index "authors", ["email"], name: "index_authors_on_email", unique: true
  add_index "authors", ["reset_password_token"], name: "index_authors_on_reset_password_token", unique: true

  create_table "ingredients", force: :cascade do |t|
    t.string   "name",       default: ""
    t.decimal  "quantity",   default: 0.0
    t.integer  "recipe_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "ingredients", ["recipe_id"], name: "index_ingredients_on_recipe_id"

  create_table "mesures", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.string   "name",             default: ""
    t.integer  "cooking_duration", default: 0
    t.integer  "baking_duration",  default: 0
    t.integer  "author_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "recipes", ["author_id"], name: "index_recipes_on_author_id"

  create_table "steps", force: :cascade do |t|
    t.integer  "count"
    t.string   "description", default: ""
    t.integer  "recipe_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "steps", ["recipe_id"], name: "index_steps_on_recipe_id"

end
