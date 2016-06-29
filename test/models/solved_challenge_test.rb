require 'test_helper'

class SolvedChallengeTest < ActiveSupport::TestCase

  def setup
    @solved_challenge_first = SolvedChallenge.new(
      player: users(:player_one),
      challenge: challenges(:challenge_two_cat_one),
      flag: flags(:flag_two)
      )
    @solved_challenge_second = SolvedChallenge.new(
      player: users(:player_one),
      challenge: challenges(:challenge_one_cat_one),
      flag: flags(:flag_one),
      division: divisions(:division_one)
    )
    @solved_challenge_third = SolvedChallenge.new(
      player: users(:player_one),
      challenge: challenges(:challenge_four_cat_two),
      flag: flags(:flag_four),
      division: divisions(:division_one)
    )
    @solved_challenge_fourth = SolvedChallenge.new(
      player: users(:player_two),
      challenge: challenges(:challenge_four_cat_two),
      flag: flags(:flag_four),
      division: divisions(:division_two)
    )
  end

  test 'description' do
    description_string =  %(Solved challenge "#{feed_items(:solved_challenge_one).challenge.category.name} #{feed_items(:solved_challenge_one).challenge.point_value}")
    assert_equal description_string, feed_items(:solved_challenge_one).description
  end

  test 'icon' do
    assert_equal 'ok', feed_items(:solved_challenge_one).icon
  end

  test 'challenge is open' do
    assert_not @solved_challenge_first.valid?
    assert_equal true, @solved_challenge_first.errors.added?(:challenge, I18n.t('challenge.not_open'))
  end

  test 'game is open' do
    game = games(:game_one)
    game.stop = Time.now
    game.save

    assert_not @solved_challenge_first.valid?
    assert_equal true, @solved_challenge_first.errors.added?(:base, I18n.t('challenge.game_not_open'))
  end

  test 'player has already solved challenge' do
    assert_not @solved_challenge_fourth.valid?
    assert_equal true, @solved_challenge_fourth.errors.added?(:base, I18n.t('challenge.already_solved'))
  end

  test 'award achievement' do
    assert_difference 'Achievement.count', +1 do
      feed_items(:solved_challenge_two).award_achievement
    end
  end

  test 'award first blood' do
    SolvedChallenge.delete_all
    assert_difference '@solved_challenge_second.player.achievements.count', +1 do
      @solved_challenge_second.save
    end
  end

  test 'open next challenge will work when not force closed' do
    @solved_challenge_third.save
    @solved_challenge_third.open_next_challenge
    assert_equal true, challenges(:challenge_five_cat_two).open?(divisions(:division_one))
    assert_equal false, challenges(:challenge_six_cat_two).open?(divisions(:division_one))
  end

  test 'open next challenge will not open next challenge when force closed' do
    @solved_challenge_second.save
    @solved_challenge_second.open_next_challenge
    assert_equal false, challenges(:challenge_two_cat_one).open?(divisions(:division_one))
    # Next challenge will also stay closed
    assert_equal false, challenges(:challenge_three_cat_one).open?(divisions(:division_one))
  end
end