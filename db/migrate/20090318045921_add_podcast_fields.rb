class AddPodcastFields < ActiveRecord::Migration
  def self.up
    add_column :podcasts, :movie_duration, :string
    add_column :podcasts, :movie_size, :integer
  end

  def self.down
    remove_column :podcasts, :movie_duration
    remove_column :podcasts, :movie_size
  end
end
