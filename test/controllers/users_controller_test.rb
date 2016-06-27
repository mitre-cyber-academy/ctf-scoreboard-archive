require 'test_helper'

class UsersControllerTest < ActionController::TestCase
    test 'player can sign in' do
        sign_in users(:player_two)
        get :index
        assert_response :success
    end
end