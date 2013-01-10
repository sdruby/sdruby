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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130110000749) do

  create_table "events", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.boolean  "is_private"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "type",        :default => "Event"
  end

  create_table "podcasts", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "movie_link"
    t.boolean  "publish"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "old_permalink"
    t.string   "screenshot_file_name"
    t.string   "screenshot_content_type"
    t.integer  "screenshot_file_size"
    t.datetime "screenshot_updated_at"
    t.string   "movie_duration"
    t.integer  "movie_size"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.datetime "github_created_at"
    t.datetime "github_pushed_at"
    t.integer  "github_watchers"
  end

  create_table "users", :force => true do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "type"
    t.text     "about"
    t.text     "links"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.string   "crypted_password",                         :null => false
    t.string   "password_salt",                            :null => false
    t.string   "persistence_token",                        :null => false
    t.string   "single_access_token",                      :null => false
    t.string   "perishable_token",                         :null => false
    t.integer  "login_count",           :default => 0,     :null => false
    t.integer  "failed_login_count",    :default => 0,     :null => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "github_username"
    t.date     "started_using_ruby_on"
    t.string   "neighborhood"
    t.boolean  "available_for_work"
    t.boolean  "show_email",            :default => false
    t.boolean  "admin",                 :default => false
    t.string   "role"
    t.integer  "sort",                  :default => 0
    t.integer  "projects_count",        :default => 0
  end

end
