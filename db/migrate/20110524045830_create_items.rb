class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.references :author
      t.references :parent
      t.string :type
      
      t.string :url #for topic
      t.string :title #for topic
      
      t.text :text
      t.integer :score
      
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
