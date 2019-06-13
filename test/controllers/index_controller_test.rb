require 'test_helper'

class IndexControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get index_url
    assert_response :success
  end

  test "should get about" do
    get about_url
    assert_response :success
  end
end
