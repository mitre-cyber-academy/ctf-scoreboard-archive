require 'test_helper'

class AchievementsControllerTest < ActionController::TestCase

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test 'index' do
    sign_in users(:player_one)
    # render
    get :index
    assert :success
  end
end
