require 'test_helper'

class NewsControllerTest < ActionDispatch::IntegrationTest
  test "should list news" do
    get news_url
    assert_response :success
  end

  test "should pagination" do
    get news_url, params: {p: 2}
    assert_response :success
  end

  test "should list results" do
    get results_url
    assert_response :success
  end

  test "should list PRO12 event" do
    get "/event/pro12"
    assert_response :success
  end

  test "should not list unknown channel" do
    get "/event/pro121"
    assert_response :found
  end

  test "should get news item" do
    get "/news/1"
    assert_response :success
  end

  test "should not get inexisted news" do
    get "/news/1000"
    assert_response :not_found
  end

  test "should get news feed" do
    get news_feed_url
    assert_response :success
  end
end
