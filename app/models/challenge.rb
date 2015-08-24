class Challenge < ActiveRecord::Base
  
  belongs_to :category

  has_many :flags, :dependent => :destroy
  
  validates :name, :point_value, :flags, :category_id, :state, presence: true
  validates :state, inclusion: %w( open closed force_closed )

  # Handles the ordering of all returned challenge objects.
  default_scope -> { order(:point_value, :name) }
  
  attr_accessor :submitted_flag
  
  def state_enum
    ['open', 'closed', 'force_closed']
  end
  
  def open?
    (self.state == "open" && self.category.game.open?)
  end
  
  def is_solved?
    (SolvedChallenge.where("challenge_id = :challenge", challenge: self).count > 0)
  end

  # Returns whether or not challenge is available to be opened.
  def available?
    self.state.eql? "closed"
  end

  def get_current_solved_challenge(user)
    solved_challenge = SolvedChallenge.where("challenge_id = :challenge and user_id = :user", challenge: self, user: user)
    solved_challenge.first unless solved_challenge.nil?
  end
 
  def is_solved_by_user?(user)
    !get_current_solved_challenge(user).nil?
  end

  def get_video_url_for_flag(user)
    current_challenge = get_current_solved_challenge(user)
    current_challenge.flag.video_url unless current_challenge.nil? || current_challenge.flag.nil?
  end

  def get_api_request_for_flag(user)
    current_challenge = get_current_solved_challenge(user)
    current_challenge.flag.api_request unless current_challenge.nil? || current_challenge.flag.nil?
  end
  
end
