require 'test_helper'

class IndexTest < ActionDispatch::IntegrationTest
  test "index page" do
    get "/index"
    assert_response :success
    assert_select "div.section-headline", "Exeter win Premiership title in extra-time"
    assert_select "div.section-top a[href=?]", "/news/3"
    assert_select "div#news .section-wrap .section-item", 20
    assert_select "div#results .section-wrap .section-item", 20
    assert_select "div#more-news-foot", 1
    assert_select "div#wiki", 1
  end

  test "404" do
    get "/maishdasu121jiaosid"
    assert_response :success
    assert_select "div.section-wrap.warning", 1
    assert_select "div.section-title", "404 Not Found"
    assert_select "div.section-content p", "找不到页面"
  end
end
