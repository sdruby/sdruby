class DropNumber < ActiveRecord::Migration
  def self.up
    remove_column :podcasts, :number
  end

  def self.down
    add_column :podcasts, :number, :string
  end
end
