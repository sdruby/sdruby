class AddOrganizerRole < ActiveRecord::Migration
  def up
    add_column :users, :role, :string
  end

  def down
    drop_column :users, :role
  end
end
