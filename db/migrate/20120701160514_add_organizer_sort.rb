class AddOrganizerSort < ActiveRecord::Migration
  def up
    add_column :users, :sort, :integer, :default => 0
  end

  def down
    drop_column :users, :sort
  end
end
