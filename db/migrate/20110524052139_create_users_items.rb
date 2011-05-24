class CreateUsersItems < ActiveRecord::Migration
  def self.up
    create_table :users_items, :id => false do |t|
      t.references :user_id, :null => false
      t.references :item_id, :null => false
      
      t.integer :vote
    end
  end

  def self.down
    drop_table :users_items
  end
end
