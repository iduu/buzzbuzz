class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.references :author, :null => false
      t.references :parent
      t.string :type
      
      t.string :url #for topic
      t.string :title #for topic
      
      t.text :text
      t.integer :score, :default => 0
      
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
