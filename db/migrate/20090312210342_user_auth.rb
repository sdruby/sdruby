class UserAuth < ActiveRecord::Migration
  def self.up
    drop_table :users
    create_table :users, :force => true do |t|
      t.string   :full_name
      t.string   :email
      t.string   :type
      t.text     :about
      t.text     :links
      t.string   :avatar_file_name
      t.string   :avatar_content_type
      t.integer  :avatar_file_size

      t.string    :crypted_password,      :null => false
      t.string    :password_salt,         :null => false
      t.string    :persistence_token,     :null => false
      t.string    :single_access_token,   :null => false
      t.string    :perishable_token,      :null => false
      t.integer   :login_count,           :null => false, :default => 0
      t.integer   :failed_login_count,    :null => false, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table "users"
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
  end
end
