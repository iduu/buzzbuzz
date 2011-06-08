class Vote < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :item
  
  #Validates
  validates_uniqueness_of :user_id, :scope => :item_id, :message => :voted
  validate :no_self_vote
  
  validates :user, :presence => true
  validates :item, :presence => true
  
  def self.make(user, item, vote)
    v = nil
    begin
      Vote.transaction do      
        v = Vote.create :user => user, :item => item, :vote => vote
        v.save!
      
        item.score += vote
        item.author.score += vote
      
        item.save!
        item.author.save!
      end
    rescue
    end
    v
  end
  
  def self.find_by_user_item(user, item)
    ret = nil
    user.votes.each do |x|
      if x.item.id == item.id
        ret = x
      end
    end
    return ret
  end
  
  def no_self_vote
    if self.item == nil || self.user == nil
      return
    end
    
    if self.item.author == self.user
      self.errors.add :user, :no_self_vote
    end

    if vote != 1 && vote != -1
      self.errors.add :vote, :what_are_you_doing
    end
  end
end
