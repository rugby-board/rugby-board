require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get news admin be redirected" do
    get admin_url
    assert_response :redirect
  end

  test "should enter news admin" do
    get admin_url, params: {token: "12ffbb6"}
    assert_response :success
  end
end
