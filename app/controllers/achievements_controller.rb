class AchievementsController < ApplicationController
  def index
    @achievements = @game.achievements.order(:text)
    @title = 'Achievements'
    @subtitle = pluralize(@achievements.count, 'achievement')
  end
end
