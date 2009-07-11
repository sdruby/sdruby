class ShowEmailAddress < ActiveRecord::Migration
  def self.up
    add_column :users, :show_email, :boolean, :default => 0
  end

  def self.down
    remove_column :users, :show_email
  end
end
