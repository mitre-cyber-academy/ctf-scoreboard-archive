class Division < ActiveRecord::Base
  after_create :add_states_to_challenges

  belongs_to :game

  has_many :players

  has_many :challenge_states, dependent: :destroy

  has_many :achievements, through: :players
  has_many :feed_items, through: :players
  has_many :solved_challenges

  validates :name, presence: true

  def ordered_players(only_top_five = false)
    eligible_players = filter_and_sort_players(eligible: true)
    ineligible_players = filter_and_sort_players(eligible: false)
    eligible_players.push(*ineligible_players)
    if only_top_five
      eligible_players[0..4]
    else
      eligible_players
    end
  end

  private

  def add_states_to_challenges
    Challenge.all.each do |c|
      ChallengeState.create!(challenge: c, division: self, state: c.starting_state)
    end
  end

  # Sorts the provided list of players.
  def filter_and_sort_players(filters)
    self.players.where(filters).sort do |a, b|
      
      #
      # get scores
      #
      a_score = a.score
      b_score = b.score
      
      # 
      # if the scores are the same sort based on the first
      # team to get to the current score
      # 
      if a_score == b_score
        
        #
        # get solved challenges
        #
        future_date = Time.now + 100.years
        a_most_recent = a.solved_challenges.order(:created_at).last
        a_date = (a_most_recent) ? a_most_recent.created_at : future_date
        b_most_recent = b.solved_challenges.order(:created_at).last
        b_date = (b_most_recent) ? b_most_recent.created_at : future_date
        
        #
        # if both teams have solved challenges
        #
        if a_date == b_date
          a.display_name <=> b.display_name
        else
          a_date <=> b_date
        end
      
      #
      # sort based on score
      #
      else
        b_score <=> a_score
      end
    end
  end
end
