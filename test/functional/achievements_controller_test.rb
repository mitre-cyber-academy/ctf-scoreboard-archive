require 'test_helper'
require 'active_record/fixtures'

class AchievementsControllerTest < ActionController::TestCase
  test 'index' do
    # render
    get :index
    assert :success
  end
end
