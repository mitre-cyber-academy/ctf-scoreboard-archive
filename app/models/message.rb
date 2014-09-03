class Message < ActiveRecord::Base
  belongs_to :game
  validates :text, :game_id, :title, presence: true
end
