require 'test_helper'

class ScoreAdjustmentTest < ActiveSupport::TestCase
  include ActionView::Helpers::TextHelper

  test 'build description' do
    # points = feed_items(:feed_item_one).point_value
    # description_string =  %(Score was increased by <span style="color:green;">#{pluralize(points.abs, 'point')}</span>)
    # assert_equal description_string, feed_items(:feed_item_one).description
    # points = feed_items(:feed_item_two).point_value
    # description_string =  %(Score was decreased by <span style="color:red;">#{pluralize(points.abs, 'point')}</span>)
    # assert_equal description_string, feed_items(:feed_item_two).description
  end

  test 'build icon' do
    icon_test = feed_items(:feed_item_one)
    assert_equal 'chevron-up', feed_items(:feed_item_one).icon
    assert_equal 'chevron-down', feed_items(:feed_item_two).icon
  end

  test 'point value is not zero' do
    score_adjustment = ScoreAdjustment.new(
      point_value: 0)
    assert_not score_adjustment.valid?
    assert_equal ['must not be zero.'], score_adjustment.errors.messages[:point_value]
  end
end