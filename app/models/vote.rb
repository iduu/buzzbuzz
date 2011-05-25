class Vote < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :item
  
  #Validates
  validates_uniqueness_of :user_id, :scope => :item_id, :message => "already voted this item"
  
  validates :user, :presence => true
  validates :item, :presence => true
end
