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

ActiveRecord::Schema.define(version: 20141113011025) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.string   "type"
    t.text     "url"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.integer  "youtube_subscription_id"
  end

  create_table "identities", force: true do |t|
    t.string   "uid"
    t.string   "provider"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "subscriptions", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["followed_id"], name: "index_subscriptions_on_followed_id", using: :btree
  add_index "subscriptions", ["follower_id", "followed_id"], name: "index_subscriptions_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "subscriptions", ["follower_id"], name: "index_subscriptions_on_follower_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "soundcloud_user_id"
    t.string   "twitter_screen_name"
    t.string   "photo"
  end

  create_table "youtube_subscriptions", force: true do |t|
    t.integer  "user_id"
    t.string   "channel_id"
    t.string   "title"
    t.boolean  "tracked",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "youtube_subscriptions", ["user_id"], name: "index_youtube_subscriptions_on_user_id", using: :btree

end
