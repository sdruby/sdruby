# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090305184445) do

  create_table "events", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.boolean  "is_private"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",        :default => "Event"
  end

  create_table "podcasts", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "movie_link"
    t.integer  "number"
    t.boolean  "publish"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "old_permalink"
  end

  create_table "users", :force => true do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "salt"
    t.string   "type"
    t.text     "about"
    t.text     "links"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
  end

  create_table "widgets", :force => true do |t|
    t.string   "setup"
    t.integer  "column"
    t.integer  "row"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "view"
  end

end
