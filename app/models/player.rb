# frozen_string_literal: true
class Player < User
  belongs_to :division

  has_many :feed_items, foreign_key: :user_id, dependent: :delete_all
  has_many :solved_challenges, foreign_key: :user_id, dependent: :delete_all
  has_many :score_adjustments, foreign_key: :user_id, dependent: :delete_all
  has_many :achievements, foreign_key: :user_id, dependent: :delete_all

  validates :division_id, :display_name, presence: true

  geocoded_by :city
  after_validation :geocode, if: :city_changed?

  # touch file in /opt/keys
  after_create :touch_file

  def score
    feed_items.where(type: [SolvedChallenge, ScoreAdjustment])
              .joins(
                'LEFT JOIN challenges ON challenges.id = feed_items.challenge_id'
              )
              .pluck(:point_value, :'challenges.point_value').flatten.compact.sum
  end

  def display_name
    return self[:display_name] if eligible
    return self[:display_name] + ' (ineligible)' unless eligible
  end

  # Grab the first 10 characters from the email and append the users ID.
  # Since we have 2 different scoreboards the ID is not sufficient, therefore
  # if we seed it with some additional data it should solve the issue.
  def key_file_name
    email.tr('^A-Za-z', '')[0..10] + id.to_s
  end

  private

  def touch_file
    system("touch /opt/keys/#{key_file_name}")
  end
end
