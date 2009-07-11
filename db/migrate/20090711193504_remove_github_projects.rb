class RemoveGithubProjects < ActiveRecord::Migration
  def self.up
    remove_column :users, :github_projects
  end

  def self.down
    add_column :users, :github_projects, :text
  end
end
