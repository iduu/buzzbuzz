class Item < ActiveRecord::Base
  has_many :children, :class_name => 'Item', :foreign_key => "parent_id"
  
  belongs_to :parent, :class_name => 'Item', :foreign_key => "parent_id"
  belongs_to :author, :class_name => 'User', :foreign_key => "author_id"
  
  has_many :votes
  has_many :voted_users, :through => :votes, :source => :user
end
