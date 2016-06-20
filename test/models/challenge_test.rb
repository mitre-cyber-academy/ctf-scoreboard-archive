require 'test_helper'

class ChallengeTest < ActiveSupport::TestCase
  # test 'challenge open' do
  #   challenge = challenges(:challenge_one)
  #   assert_equal true, challenge.challenge_open?(challenge)
  # end

  # test 'challenge closed' do
  #   assert_equal false, challenges(:challenge_two).challenge_open?
  # end

  # test 'challenge force_closed' do
  #   assert_equal false, challenges(:challenge_three).challenge_open?
  # end

  test 'is challenge solved' do
    assert_equal false, challenges(:challenge_one).solved?
  end
end