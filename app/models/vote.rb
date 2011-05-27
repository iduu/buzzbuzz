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
      v = Vote.create user:user, item:item, vote:vote
      
      if item.author == user
        raise "user cannot vote for his submits"
      end
      
      if vote < 0
        if user.score < vote.abs
          raise "user doesn't have enough score to vote negatively"
        else
          user.score -= vote.abs
        end
      end
      
      item.score += vote
      item.author.score += vote
    end
    v
  end
end
