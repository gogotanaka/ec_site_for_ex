require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get history" do
    get :history
    assert_response :success
  end

end
