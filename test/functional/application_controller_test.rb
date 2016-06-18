require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test 'to timeline' do
  end

  test 'enable auto reload' do
  end

  test 'load game' do
  end

  test 'load messages count' do
  end

  test 'enforce access' do
  end

  test 'after sign in path' do
  end
end
