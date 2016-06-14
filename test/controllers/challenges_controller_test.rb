require 'test_helper'
class ChallengesController < ActionController::TestCase
  test 'check challenge name' do
    @title = challenges(:game_one)
    # puts @title.name.inspect
    assert_equal(true, @title.name.present?)
  end

  test 'check flag submitted' do
    @key = submitted_flags(:flag_one)
    assert_equal(true, @key.text.present?)
  end

  test 'see if challenge is solved' do
    @game = submitted_flags(:flag_one)
  end
end
