require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get indexy" do
    get :indexy
    assert_response :success
  end

end
