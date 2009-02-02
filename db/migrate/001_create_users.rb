class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :full_name, :email, :password_digest, :salt, :type
      t.text :about, :links

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
