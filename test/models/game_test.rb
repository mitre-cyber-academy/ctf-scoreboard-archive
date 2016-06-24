require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test 'instance is singleton' do
  end

  test 'order of start and stop date' do
  end

  test 'open' do
    game = games(:game_one)
    game_start = game.start
    game_stop = game.stop
    assert_equal true, game.open?
  end
end