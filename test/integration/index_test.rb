require 'test_helper'

class IndexTest < ActionDispatch::IntegrationTest
  test "index page" do
    get "/index"
    assert_response :success
    assert_select "div.news-headline", "Exeter win Premiership title in extra-time"
    assert_select "div.news-title a[href=?]", "/news/3"
    assert_select "div#news .news-wrap .news-item", 20
    assert_select "div#results .news-wrap .news-item", 20
    assert_select "div#wiki", 1
  end

  test "404" do
    get "/maishdasu121jiaosid"
    assert_response :success
    assert_select "div.news-wrap.warning", 1
    assert_select "div.news-title", "404 Not Found"
    assert_select "div.news-content p", "找不到页面"
  end
end
