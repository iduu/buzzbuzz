class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.references :user, :null => false
      t.references :item, :null => false
      
      t.integer :vote
    end
  end

  def self.down
    drop_table :votes
  end
end
