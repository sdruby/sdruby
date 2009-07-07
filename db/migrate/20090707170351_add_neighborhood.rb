class AddNeighborhood < ActiveRecord::Migration
  def self.up
    add_column :users, :neighborhood, :string
  end

  def self.down
    remove_column :users, :neighborhood
  end
end
