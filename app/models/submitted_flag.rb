class SubmittedFlag < ActiveRecord::Base
  belongs_to :player, foreign_key: :user_id
  belongs_to :challenge
  validates :text, presence: true
end
