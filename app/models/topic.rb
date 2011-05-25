class Topic < Item
  # Validates
  validates :title, :presence => true
                    :length => { maximum: 30 } 
  
  validates :url, :presence => true
end
