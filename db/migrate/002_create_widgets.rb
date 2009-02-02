class CreateWidgets < ActiveRecord::Migration
  def self.up
    create_table :widgets do |t|
      t.string :setup
      t.string :view
      t.integer :column
      t.integer :row

      t.timestamps
    end
  end

  def self.down
    drop_table :widgets
  end
end
