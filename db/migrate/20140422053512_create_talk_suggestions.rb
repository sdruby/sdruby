class CreateTalkSuggestions < ActiveRecord::Migration
  def change
    create_table :talk_suggestions do |t|
      t.string :name
      t.text :description
      t.string :style
      t.string :suggested_speaker
      t.integer :created_by_id
      t.integer :vote_count, :default => 0

      t.timestamps
    end

    add_column :users, :last_voted_at, :datetime
  end
end
