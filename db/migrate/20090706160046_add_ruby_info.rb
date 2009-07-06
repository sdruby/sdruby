class AddRubyInfo < ActiveRecord::Migration
  def self.up
    add_column :users, :started_using_ruby_on, :date
  end

  def self.down
    remove_column :users, :started_using_ruby_on
  end
end
