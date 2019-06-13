require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should not enter news admin, should be redirected" do
    get admin_url
    assert_response :redirect
  end

  test "should enter news admin" do
    get admin_url, params: {token: "12ffbb6"}
    assert_response :success
  end

  test "should edit news" do
  	get admin_url, params: {token: "12ffbb6", id: 1}
  	assert_response :success
  end
end
