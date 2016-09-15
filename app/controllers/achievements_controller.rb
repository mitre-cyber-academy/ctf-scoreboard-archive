# frozen_string_literal: true
class AchievementsController < ApplicationController
  def index
    @achievements = @game.achievements.order(:text)
    @title = 'Achievements'
    @subtitle = pluralize(@achievements.size, 'achievement')
  end
end
