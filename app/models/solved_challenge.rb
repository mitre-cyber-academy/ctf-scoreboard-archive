class SolvedChallenge < FeedItem
  
  validates :challenge_id, :flag, presence: true
  validate :user_has_not_solved_challenge, :challenge_is_open, :game_is_open
  
  after_save :award_achievement, :open_next_challenge

  belongs_to :flag
  belongs_to :division
  
  def description
    %[Solved challenge "#{self.challenge.category.name} #{self.challenge.point_value}"]
  end
  
  def icon
    "ok"
  end
  
  def challenge_is_open
    unless self.challenge.open?(self.player.division)
      errors.add(:challenge, "must be open.")
    end
  end
  
  def game_is_open
    unless self.challenge.category.game.open?
      errors.add(:base, "The game must be open.")
    end
  end
  
  def user_has_not_solved_challenge
    if self.player.solved_challenges.where("challenge_id = ?", self.challenge.id).count > 0
      errors.add(:base, "This player has already solved this challenge.")
    end
  end
  
  def award_achievement
    if Game.instance.solved_challenges.all.count == 1 # if this is the first solved challenge
      Achievement.create(player: self.player, text: "First Blood!")
    end
    name = self.challenge.achievement_name
    unless name.blank?
      Achievement.create(player: self.player, text: name)
    end
  end
  
  def open_next_challenge
    challenge = self.challenge
    category = challenge.category
    challenge = category.next_challenge(challenge)
    if challenge && challenge.available?(self.player.division)
      challenge.set_state(self.player.division, "open")
    end
  end
  
end
