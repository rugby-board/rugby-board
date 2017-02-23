require 'test_helper'

class NewsControllerTest < ActionDispatch::IntegrationTest
  test "should get news list" do
    get news_url
    assert_response :success
  end

  test "should get news feed" do
    get news_feed_url
    assert_response :success
  end
end
