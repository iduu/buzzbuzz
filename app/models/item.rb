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
    type = type || :best
    page = options[:page] || 0
    size = options[:per_page] || 30

    content = sort(type, all())
    part = content[page * size..(page + 1) * size - 1];
    if part != nil
      result = Page.new(part)
    else
      result = Page.new
    end
    result.current_page = page
    result.total_page = (content.count / size).ceil
    result
  end
  
  def self.sort(type, content)
    now = Time.now
    sort_block = nil
    case type
    when :best
      sort_block = lambda { |x| - x.score / ((now - x.created_at) ** 1.5) }
    when :recent
      sort_block = lambda { |x| - x.created_at.to_i }
    when :worst
      sort_block = lambda { |x| x.score / ((now - x.created_at) ** 1.5) }
    else
      raise "illegal sorting type: #{type}"
    end
    
    content = content.sort_by do |x|
      sort_block.call x
    end
  end
  
  def root
    ret = self
    while ret.parent != nil
      ret = ret.parent
    end
    ret
  end
end
