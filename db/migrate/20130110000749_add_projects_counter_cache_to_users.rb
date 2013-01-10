class AddProjectsCounterCacheToUsers < ActiveRecord::Migration
  def change
    add_column :users, :projects_count, :integer, default: 0
  end
end
