require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test 'index' do
    sign_in users(:player_one)
    get :index
    assert :success
  end

  test 'show' do
  end

  test 'download' do
  end
end
