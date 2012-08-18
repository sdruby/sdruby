class AddOrganizerSort < ActiveRecord::Migration
  def up
    add_column :users, :sort, :integer, :default => false
  end

  def down
    drop_column :users, :sort
  end
end
