class Game < ActiveRecord::Base
  
  # players
  has_many :players
  has_many :achievements, through: :players
  has_many :feed_items, through: :players
  has_many :solved_challenges, through: :players
  
  # challenges
  has_many :categories
  has_many :challenges, through: :categories
  
  # messages
  has_many :messages
  
  # validation
  validates :name, :start, :stop, presence: true
  validate :instance_is_singleton, :order_of_start_and_stop_date
  
  # class methods
  
  def self.instance
    self.all.first
  end
  
  # validators
  
  def instance_is_singleton
    singleton = Game.instance
    if self != singleton && !singleton.nil?
      errors.add(:base, "You may not create more than one game.")
    end
  end
  
  def order_of_start_and_stop_date
    unless self.start < self.stop
      errors.add(:base, "The start date must be before the end date.")
    end
  end
  
  # helper methods
  
  def open?
    time = Time.now
    (self.start < time && time < self.stop )
  end
  
  def ordered_players
    self.players.sort do |a, b|
      
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
