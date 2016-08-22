# frozen_string_literal: true
class ChallengeState < ActiveRecord::Base
  before_validation :default_values
  belongs_to :challenge
  belongs_to :division

  validates :challenge_id, uniqueness: { scope: :division_id }

  validates :state, :challenge, presence: true

  enum state: [:open, :closed, :force_closed]

  def default_values
    self.state ||= ChallengeState.states[:closed]
  end
end
