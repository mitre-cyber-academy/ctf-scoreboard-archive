require 'test_helper'

class SolvedChallengeTest < ActiveSupport::TestCase

  test 'description' do
    description_string =  %(Solved challenge "#{feed_items(:solved_challenge_one).challenge.category.name} #{feed_items(:solved_challenge_one).challenge.point_value}")
    assert_equal description_string, feed_items(:solved_challenge_one).description
  end

  test 'icon' do
    assert_equal 'ok', feed_items(:solved_challenge_one).icon
  end

  test 'challenge is open' do
    solved_challenge = SolvedChallenge.new(
      player: users(:player_one),
      challenge: challenges(:challenge_two),
      flag: flags(:flag_two)
      )
    assert_not solved_challenge.valid?
    assert_equal true, solved_challenge.errors.added?(:challenge, I18n.t('challenge.not_open'))
  end

  test 'game is open' do
    game = games(:game_one)
    game.stop = Time.now
    game.save

    solved_challenge = SolvedChallenge.new(
      player: users(:player_one),
      challenge: challenges(:challenge_two),
      flag: flags(:flag_two)
    )

    assert_not solved_challenge.valid?
    assert_equal true, solved_challenge.errors.added?(:base, I18n.t('challenge.game_not_open'))
  end

  test 'player has already solved challenge' do
    # solved_challenge = SolvedChallenge.new(
    #   player: users(:player_two),
    #   challenge: challenges(:challenge_four),
    #   flag: flags(:flag_four),
    #   division: divisions(:division_two)
    # )

    # assert_not solved_challenge.valid?
    # assert_equal true, solved_challenge.errors.added?(:base, I18n.t('challenge.already_solved'))
  end

  test 'award achievement' do
    assert_difference 'Achievement.count', +1 do
      feed_items(:solved_challenge_one).award_achievement
    end
  end

  test 'open next challenge' do
    solved_challenge = SolvedChallenge.new(
      player: users(:player_one),
      challenge: challenges(:challenge_one),
      flag: flags(:flag_one),
      division: divisions(:division_one)
    )
    solved_challenge.save!
    solved_challenge.open_next_challenge
    assert_equal true, challenges(:challenge_five).open?(divisions(:division_one))
  end
end