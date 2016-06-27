require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'next challenge' do
    category_one = categories(:category_one)
    challenge_one = challenges(:challenge_one)
    assert_equal challenges(:challenge_five), category_one.next_challenge(challenge_one)
  end
end