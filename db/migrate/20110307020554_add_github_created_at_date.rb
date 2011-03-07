class AddGithubCreatedAtDate < ActiveRecord::Migration
  def self.up
    add_column :projects, :github_created_at, :datetime
  end

  def self.down
    remove_column :projects, :github_created_at
  end
end
