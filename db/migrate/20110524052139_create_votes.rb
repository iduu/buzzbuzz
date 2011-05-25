class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.references :user
      t.references :item
      
      t.integer :vote, :default => 0
    end
  end

  def self.down
    drop_table :votes
  end
end
