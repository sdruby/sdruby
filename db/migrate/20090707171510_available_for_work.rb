class AvailableForWork < ActiveRecord::Migration
  def self.up
    add_column :users, :available_for_work, :boolean
  end

  def self.down
    remove_column :users, :available_for_work
  end
end
