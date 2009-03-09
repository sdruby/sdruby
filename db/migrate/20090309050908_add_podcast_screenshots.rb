class AddPodcastScreenshots < ActiveRecord::Migration
  def self.up
    add_column :podcasts, :screenshot_file_name,    :string
    add_column :podcasts, :screenshot_content_type, :string
    add_column :podcasts, :screenshot_file_size,    :integer
    add_column :podcasts, :screenshot_updated_at,   :datetime
  end

  def self.down
    remove_column :podcasts, :screenshot_file_name
    remove_column :podcasts, :screenshot_content_type
    remove_column :podcasts, :screenshot_file_size
    remove_column :podcasts, :screenshot_updated_at
  end
end
