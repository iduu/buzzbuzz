class AddScoreToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :score, :integer, :default => 1
  end

  def self.down
    remove_column :users, :score
  end
end
