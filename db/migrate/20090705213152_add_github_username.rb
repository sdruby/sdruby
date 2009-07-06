class AddGithubUsername < ActiveRecord::Migration
  def self.up
    add_column :users, :github_username, :string
  end

  def self.down
    remove_column :users, :github_username
  end
end
