class Player < User
  
  belongs_to :division
  
  has_many :feed_items, foreign_key: :user_id, dependent: :delete_all
  has_many :solved_challenges, foreign_key: :user_id
  has_many :score_adjustments, foreign_key: :user_id
  has_many :achievements, foreign_key: :user_id
  has_many :keys, foreign_key: :user_id, dependent: :delete_all
  
  validates :division_id, :display_name, presence: true
  
  geocoded_by :city
  after_validation :geocode, :if => :city_changed?

  #touch file in /opt/keys
  after_create :touch_file

  def score
    points = 0
    self.solved_challenges.includes(:challenge).each do |s|
      points = points + s.challenge.point_value
    end
    self.score_adjustments.each do |a|
      points = points + a.point_value
    end
    points
  end

  def display_name
    if self.eligible
      return read_attribute(:display_name)
    else
      return read_attribute(:display_name) + " (ineligible)"
    end
  end

  # Grab the first 10 characters from the email and append the users ID.
  # Since we have 2 different scoreboards the ID is not sufficient, therefore
  # if we seed it with some additional data it should solve the issue.
  def key_file_name
    self.email.tr('^A-Za-z', '')[0..10] + self.id.to_s
  end

  private
  
  def touch_file
    `touch /opt/keys/#{self.key_file_name}` 
  end
  
end
