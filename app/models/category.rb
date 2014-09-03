class Category < ActiveRecord::Base
  
  belongs_to :game
  
  has_many :challenges
  
  validates :name, :game_id, presence: true
  
  def next_challenge(challenge)
    self.challenges.order("point_value ASC").where("point_value > ?", challenge.point_value).first
  end
  
end
