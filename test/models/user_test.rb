require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'is an admin' do
    assert_equal true, users(:admin_one).admin?
  end

  test 'set password' do
    assert_nil users(:player_one).set_password
  end

  test 'set password with value' do
    password = 'NewTestPassword123'
    assert_nil users(:player_one).set_password=()
    assert_equal password, users(:player_one).set_password=(password)
  end
end