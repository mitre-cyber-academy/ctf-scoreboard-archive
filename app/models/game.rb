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
    if self != singleton && !singleton.nil?
      errors.add(:base, 'You may not create more than one game.')
    end
  end

  def order_of_start_and_stop_date
    unless start < stop
      errors.add(:base, 'The start date must be before the end date.')
    end
  end

  # helper methods

  def open?
    time = Time.now
    (start < time && time < stop)
  end
end
