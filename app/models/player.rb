class Player < User
  
  belongs_to :game
  
  has_many :feed_items, foreign_key: :user_id, dependent: :delete_all
  has_many :solved_challenges, foreign_key: :user_id
  has_many :score_adjustments, foreign_key: :user_id
  has_many :achievements, foreign_key: :user_id
  has_many :keys, foreign_key: :user_id, dependent: :delete_all
  
  validates :game_id, :display_name, presence: true
  
  attr_accessible :game_id, :tags, :display_name, :city, :affiliation
  geocoded_by :city
  after_validation :geocode, :if => :city_changed?


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
  
end
