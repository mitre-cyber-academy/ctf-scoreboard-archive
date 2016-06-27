require 'test_helper'

class GameTest < ActiveSupport::TestCase

  test 'instance is singleton' do
    game = Game.new(
      name: 'game',
      start: Time.now,
      stop: Time.now - 10.hours,
      description: 'game description',
      tos: 'game tos',
      irc: 'game irc'
    )
    assert_not game.valid?
    assert game.errors.messages[:base].include?(I18n.t('game.too_many'))
  end

  test 'order of start stop date' do
    game = Game.new(
      name: 'game',
      start: Time.now,
      stop: Time.now - 10.hours,
      description: 'game description',
      tos: 'game tos',
      irc: 'game irc'
    )
    assert_not game.valid?
    assert game.errors.messages[:base].include?(I18n.t('game.date_mismatch'))
  end

  test 'open' do
    assert_equal true, games(:game_one).open?
  end
end