class DropJobs < ActiveRecord::Migration
  def up
    drop_table :jobs
  end

  def down
    create_table "jobs", :force => true do |t|
      t.integer  "user_id"
      t.string   "title"
      t.text     "description"
      t.boolean  "published"
      t.boolean  "contract"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
