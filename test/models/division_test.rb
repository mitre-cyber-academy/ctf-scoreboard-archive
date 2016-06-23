require 'test_helper'

class DivisionTest < ActiveSupport::TestCase
  test 'ordered players' do
    division = divisions(:division_one)
    # checking if the array is empty
    assert_equal false, division.ordered_players.empty?, 'array is empty'
    assert_equal 3, division.ordered_players.size
  end

  test 'add states to challenges' do
  end

  test 'filter and sort players' do
  end
end