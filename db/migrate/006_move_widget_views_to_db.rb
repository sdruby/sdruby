class MoveWidgetViewsToDb < ActiveRecord::Migration
  def self.up
    remove_column :widgets, :view
    add_column :widgets, :view, :text
  end

  def self.down
    remove_column :widgets, :view
    add_comlumn :widgets, :view, :string
  end
end
