require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test 'index' do
    sign_in users(:player_two)
    get :index
    assert_response :success
  end

  test 'show' do
  end

  test 'download' do
  end
end
