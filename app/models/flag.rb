class Flag < ActiveRecord::Base
  belongs_to :challenge, inverse_of: :flags

  has_many :solved_challenges, through: :challenge

  validates :flag, presence: true
end
