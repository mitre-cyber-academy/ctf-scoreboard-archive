require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'next challenge' do
    categories_one = categories(:binary)
    challenge_two = challenges(:challenge_two)
    challenge_three = challenges(:challenge_three)
    assert_equal challenge_two, categories_one.next_challenge(challenge_three)
  end
end