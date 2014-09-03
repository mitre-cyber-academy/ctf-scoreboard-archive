class Achievement < FeedItem
  
  validates :text, presence: true, uniqueness: true
  
  def description
    return %[Unlocked achievement "#{self.text}"]
  end
  
  def icon
    "certificate"
  end
  
end
