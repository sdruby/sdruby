class RemoveWidgets < ActiveRecord::Migration
  def self.up
    drop_table :widgets
  end

  def self.down
    create_table "widgets", :force => true do |t|
      t.string   "setup"
      t.integer  "column"
      t.integer  "row"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.text     "view"
    end
  end
end
