class FeedItem < ActiveRecord::Base
  belongs_to :player, foreign_key: :user_id
  belongs_to :challenge
  validates :user_id, :type, presence: true
  validates :type, inclusion: %w( SolvedChallenge Achievement ScoreAdjustment )

  def description
    self.class
  end

  def icon
    ''
  end
end
