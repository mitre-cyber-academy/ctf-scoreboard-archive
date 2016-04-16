class Challenge < ActiveRecord::Base
  
  belongs_to :category

  has_many :challenge_states
  
  has_many :flags, :dependent => :destroy, inverse_of: :challenge
  has_many :solved_challenges, through: :games
  
  validates :name, :point_value, :flags, :category_id, :state, presence: true

  accepts_nested_attributes_for :flags, :allow_destroy => true

  validates :state, inclusion: %w( open closed force_closed )

  # Handles the ordering of all returned challenge objects.
  default_scope -> { order(:point_value, :name) }
  
  attr_accessor :submitted_flag

  def state_enum
    ['open', 'closed', 'force_closed']
  end
  
  # This bypasses game open check and only looks at the challenge state
  def challenge_open?
    self.state == "open"
  end  
  
  def open?
    (self.challenge_open? && self.category.game.open?)
  end
  
  def is_solved?
    (SolvedChallenge.where("challenge_id = :challenge", challenge: self).count > 0)
  end

  # Returns whether or not challenge is available to be opened.
  def available?
    self.state.eql? "closed"
  end

  def force_closed?
    self.state.eql? "force_closed"
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
