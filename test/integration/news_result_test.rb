require 'test_helper'

class NewsResultTest < ActionDispatch::IntegrationTest
  test "news page in the beginning" do
    get "/news"
    assert_response :success
    assert_select "div#news div.section-wrap div.section-item", 20
    assert_select "div#pagination span#total", "44"
    assert_select "div#pagination span#current", "1"
    assert_select "div#pagination a", 1
  end

  test "news page in the middle" do
    get "/news?p=2"
    assert_response :success
    assert_select "div#news div.section-wrap div.section-item", 20
    assert_select "div#pagination span#total", "44"
    assert_select "div#pagination span#current", "2"
    assert_select "div#pagination a", 2
  end

  test "news page in the end" do
    get "/news?p=3"
    assert_response :success
    assert_select "div#news div.section-wrap div.section-item", 4
    assert_select "div#pagination span#total", "44"
    assert_select "div#pagination span#current", "3"
    assert_select "div#pagination a", 1
  end

  test "view result" do
    get "/results"
    assert_response :success
    assert_select "div#news div.section-wrap div.section-item", 20
    assert_select "div#pagination span#total", "42"
    assert_select "div#pagination span#current", "1"
    assert_select "div#pagination a", 1
  end
end
