class Vote < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :item
  
  #Validates
  validates_uniqueness_of :user_id, :scope => :item_id, :message => "already voted this item"
  
  validates :user, :presence => true
  validates :item, :presence => true
  
  def self.make(user, item, vote)
    v = nil
    Vote.transaction do
      if item.author == user
        raise "user cannot vote for his submits"
      end

      if vote != 1 && vote != -1
        raise "user's vote amount is not valid"
      end

      item.score += vote
      item.author.score += vote
      
      item.save!
      item.author.save!
      
      v = Vote.create user:user, item:item, vote:vote
    end
    v
  end
end
