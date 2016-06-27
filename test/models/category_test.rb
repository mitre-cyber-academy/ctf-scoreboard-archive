require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'next challenge' do
    category_one = categories(:category_one)
    challenge_one = challenges(:challenge_one)
    challenge_two = challenges(:challenge_two)
    assert_equal challenge_two, category_one.next_challenge(challenge_one)
  end
end