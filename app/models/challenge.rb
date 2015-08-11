class Challenge < ActiveRecord::Base
  
  belongs_to :category
  
  validates :name, :point_value, :flag, :category_id, :state, presence: true
  validates :state, inclusion: %w( open closed )

  default_scope -> { order(point_value: :asc, name: :asc) }
  
  attr_accessor :submitted_flag
  
  def state_enum
    ['open', 'closed']
  end
  
  def open?
    (self.state == "open" && self.category.game.open?)
  end
  
  def is_solved?
    (SolvedChallenge.where("challenge_id = :challenge", challenge: self).count > 0)
  end
  
  def is_solved_by_user?(user)
    (SolvedChallenge.where("challenge_id = :challenge and user_id = :user", challenge: self, user: user).count > 0)
  end
  
end
