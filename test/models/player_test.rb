class PlayerTest < ActiveSupport::TestCase
  test 'score' do
    assert_equal 0, users(:player_one).score
    # Figure out how to attach feed items/scoreadjustment to players
    # assert_equal 100, users(:player_two).score
  end

  test 'display name' do
    # Eligible
    assert_equal users(:player_one).display_name, users(:player_one).display_name
    # Ineligible
    assert_equal users(:player_three).display_name, users(:player_three).display_name
  end

  test 'key file name' do
    key_phile_name = 'playeronete@' + users(:player_one).id.to_s
    assert_equal key_phile_name, users(:player_one).key_file_name
  end
end