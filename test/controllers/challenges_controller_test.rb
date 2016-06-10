require 'test_helper'
class ChallengesController < ActionController::TestCase



  test 'check challenge name' do
    @title = challenges(:Harry)
    puts @title.name.inspect
    assert_equal(true, @title.name.present?)
  end

  test 'check flag submitted' do
  	@key = submitted_flags(:Harry)
  	assert_equal(true, @key.text.present?)
  end
end