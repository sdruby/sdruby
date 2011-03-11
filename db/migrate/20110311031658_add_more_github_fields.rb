class AddMoreGithubFields < ActiveRecord::Migration
  def self.up
    add_column :projects, :github_pushed_at, :datetime
    add_column :projects, :github_watchers, :integer
  end

  def self.down
    remove_column :projects, :github_pushed_at
    remove_column :projects, :github_watchers
  end
end
