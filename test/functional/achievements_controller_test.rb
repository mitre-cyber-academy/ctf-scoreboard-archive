require 'test_helper'
require 'active_record/fixtures'

class AchievementsControllerTest < ActionController::TestCase
  def setup
  end

  test 'player gets achievement' do
    assert true
  end

  test 'name of achievement' do
    assert_respond_to 'Achievements', :index
    assert true
  end
end
