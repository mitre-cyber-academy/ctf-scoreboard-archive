class Game < ActiveRecord::Base
  # players
  has_many :players, through: :divisions

  # feed items
  has_many :feed_items, through: :divisions
  has_many :achievements, through: :divisions

  # divisions
  has_many :divisions

  # challenges
  has_many :categories
  has_many :challenges, through: :categories
  has_many :solved_challenges, through: :divisions

  # messages
  has_many :messages

  # validation
  validates :name, :start, :stop, presence: true
  validate :instance_is_singleton, :order_of_start_and_stop_date

  # class methods

  def self.instance
    all.first
  end

  # validators

  def instance_is_singleton
    singleton = Game.instance
    errors.add(:base, I18n.t('game.too_many')) if self != singleton && !singleton.nil?
  end

  def order_of_start_and_stop_date
    errors.add(:base, I18n.t('game.date_mismatch')) unless start < stop
  end

  # helper methods

  def open?
    time = Time.zone.now
    (start < time && time < stop)
  end
end
