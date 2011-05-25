class Comment < Item
  # Validates
  validates :parent, :presence => true
  
end