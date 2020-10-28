require 'test_helper'

class MastermindControllerTest < ActionDispatch::IntegrationTest
  test "should get game" do
    get mastermind_game_url
    assert_response :success
  end

end
