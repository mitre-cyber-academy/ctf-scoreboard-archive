require 'test_helper'

class UsersController < ActionController::TestCase
  def setup
    @harry = User.new(email: 'user4@test.com',
                      password: 'TestPassword123',
                      eligible: false,
                      city: 'Tarpon Springs')
  end

  test 'something' do
    # asset_equal()
  end
end
