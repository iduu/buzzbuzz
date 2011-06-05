class Item < ActiveRecord::Base
  # Relations
  belongs_to :parent, :class_name => 'Item', :foreign_key => "parent_id"
  belongs_to :author, :class_name => 'User', :foreign_key => "author_id"
  
  has_many :votes
  has_many :voted_users, :through => :votes, :source => :user
  
  has_many :children, :class_name => 'Item', :foreign_key => "parent_id"
  
  # Validates
  validates :author, :presence => true
  
  validates :text, :presence => true
  
  # Get content for type, with page & page size
  def self.content_for(type, options = {})
    page = options[:page] || 0
    size = options[:size] || 30
    now = Time.now
    
    sort_block = nil
    case type
    when :best
      sort_block = lambda { |x| (x.score - 1) / ((now - x.created_at) ** 1.5) }
    when :recent
      sort_block = lambda { |x| - x.created_at.to_i }
    when :worst
      sort_block = lambda { |x| - (x.score - 1) / ((now - x.created_at) ** 1.5) }
    else
      raise "illegal sorting type: #{type}"
    end
    
    content = all.sort_by do |x|
      sort_block.call x
    end
    
    content[page * size..size]
  end
end
