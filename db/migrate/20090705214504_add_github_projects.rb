class AddGithubProjects < ActiveRecord::Migration
  def self.up
    add_column :users, :github_projects, :text
  end

  def self.down
    remove_column :users, :github_projects
  end
end
