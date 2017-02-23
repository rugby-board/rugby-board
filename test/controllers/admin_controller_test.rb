require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get news admin" do
    get admin_url
    assert_response :redirect
  end
end
