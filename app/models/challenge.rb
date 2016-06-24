class Challenge < ActiveRecord::Base
  after_create :add_states_to_challenges

  belongs_to :category

  has_many :challenge_states, dependent: :destroy

  has_many :solved_challenges, through: :flags

  has_many :submitted_flags

  has_many :flags, dependent: :destroy, inverse_of: :challenge

  validates :name, :point_value, :flags, :category_id, presence: true

  enum starting_state: ChallengeState.states

  accepts_nested_attributes_for :flags, allow_destroy: true

  # Handles the ordering of all returned challenge objects.
  default_scope -> { order(:point_value, :name) }

  attr_accessor :submitted_flag

  # This bypasses game open check and only looks at the challenge state
  def challenge_open?(division)
    get_state(division).eql? 'open'
  end

  def open?(division)
    (challenge_open?(division) && category.game.open?)
  end

  def solved?
    (SolvedChallenge.where('challenge_id = :challenge', challenge: self).count > 0)
  end

  # Returns whether or not challenge is available to be opened.
  def available?(division)
    get_state(division).eql? 'closed'
  end

  def force_closed?(division)
    get_state(division).eql? 'force_closed'
  end

  def get_current_solved_challenge(user)
    solved_challenge = SolvedChallenge.where('challenge_id = :challenge and user_id = :user',
                                             challenge: self, user: user)
    solved_challenge.first unless solved_challenge.nil?
  end

  def solved_by_user?(user)
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

  def set_state(division, new_state)
    challenge_state = chalelnge_states.find_by(division: division)
    challenge_state.state = new_state
    challenge_state.save
  end

  private

  # Gets the state using a division context
  def get_state(division)
    challenge_states.find_by(division: division).state
  end

  def add_states_to_challenges
    Division.all.find_each do |d|
      ChallengeState.create!(challenge: self, division: d, state: starting_state)
    end
  end
end
