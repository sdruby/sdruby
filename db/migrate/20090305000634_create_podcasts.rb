class CreatePodcasts < ActiveRecord::Migration
  def self.up
    create_table :podcasts do |t|
      t.string :name
      t.text :description
      t.string :movie_link
      t.integer :number
      t.boolean :publish

      t.timestamps
    end
  end

  def self.down
    drop_table :podcasts
  end
end
