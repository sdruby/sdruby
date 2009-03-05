class UpdatePodcast < ActiveRecord::Migration
  def self.up
    add_column :podcasts, :old_permalink, :string
  end

  def self.down
    remove_column :podcasts, :old_permalink
  end
end
